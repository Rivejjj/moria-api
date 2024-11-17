class RepositorioContenidoDeUsuario
  def save(usuario)
    save_playlist(usuario)
    RepositorioReproduccionesDeUsuario.new.save(usuario)
    save_me_gustas(usuario)
  end

  def delete_all
    DB[:playlists_usuarios_contenido].delete
    RepositorioReproduccionesDeUsuario.new.delete_all
    DB[:me_gustas].delete
  end

  def load_a_usuario(usuario)
    load_playlist(usuario)
    load_reproducciones(usuario)
    load_me_gustas(usuario)
  end

  protected

  def save_playlist(usuario)
    contenido_nuevo_playlist = filtrar_contenido_nuevo_playlist(usuario)
    max_orden = obtener_max_orden_playlist(usuario)
    insertar_contenido_nuevo(usuario, contenido_nuevo_playlist, max_orden)
  end

  def save_contenido_de_usuario(db, usuario_id, contenidos)
    contenidos.each do |contenido|
      db.insert(id_usuario: usuario_id, id_contenido: contenido.id) unless contenido_de_usuario_ya_en_db?(db, contenido.id, usuario_id)
    end
  end

  def save_me_gustas(usuario)
    save_contenido_de_usuario(DB[:me_gustas], usuario.id, usuario.me_gustas)
  end

  def contenido_de_usuario_ya_en_db?(db, id_contenido, id_usuario)
    db_filtrado = db.where(id_usuario:, id_contenido:)
    !db_filtrado.first.nil?
  end

  def filtrar_contenido_nuevo_playlist(usuario)
    ids_contenido_playlist_guardada = obtener_ids_contenido_playlist_guardada(usuario)
    usuario.playlist.reject { |contenido| ids_contenido_playlist_guardada.include?(contenido.id) }
  end

  def obtener_ids_contenido_playlist_guardada(usuario)
    DB[:playlists_usuarios_contenido].where(id_usuario: usuario.id).select_map(:id_contenido)
  end

  def obtener_max_orden_playlist(usuario)
    DB[:playlists_usuarios_contenido].where(id_usuario: usuario.id).max(:orden) || 0
  end

  def insertar_contenido_nuevo(usuario, contenido_nuevo_playlist, max_orden)
    contenido_nuevo_playlist.each_with_index do |contenido, i|
      DB[:playlists_usuarios_contenido].insert(
        id_usuario: usuario.id,
        id_contenido: contenido.id,
        orden: max_orden + i + 1
      )
    end
  end

  def find_me_gustas(usuario)
    repositorio_contenido = RepositorioContenido.new
    me_gustas = DB[:me_gustas]
    me_gustas_filtrado = me_gustas.where(id_usuario: usuario.id)
    me_gustas = []
    me_gustas_filtrado.each do |fila|
      me_gustas << repositorio_contenido.find(fila[:id_contenido])
    end
    me_gustas
  end

  def load_playlist(usuario)
    playlist = RepositorioContenido.new.find_playlist_by_usuario(usuario)
    playlist.each do |contenido|
      usuario.agregar_a_playlist(contenido)
    end
  end

  def load_reproducciones(usuario)
    RepositorioReproduccionesDeUsuario.new.load(usuario)
  end

  def load_me_gustas(usuario)
    me_gustas = find_me_gustas(usuario)
    me_gustas.each do |contenido|
      usuario.me_gusta(contenido)
    end
  end
end
