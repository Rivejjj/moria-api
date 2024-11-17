class RepositorioContenidoDeUsuario
  def save(usuario)
    save_playlist(usuario)
    RepositorioReproduccionesDeUsuario.new.save(usuario)
    RepositorioMeGustasDeUsuario.new.save(usuario)
  end

  def delete_all
    DB[:playlists_usuarios_contenido].delete
    RepositorioReproduccionesDeUsuario.new.delete_all
    RepositorioMeGustasDeUsuario.new.delete_all
  end

  def load_a_usuario(usuario)
    load_playlist(usuario)
    RepositorioReproduccionesDeUsuario.new.load(usuario)
    RepositorioMeGustasDeUsuario.new.load(usuario)
  end

  protected

  def save_playlist(usuario)
    contenido_nuevo_playlist = filtrar_contenido_nuevo_playlist(usuario)
    max_orden = obtener_max_orden_playlist(usuario)
    insertar_contenido_nuevo(usuario, contenido_nuevo_playlist, max_orden)
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

  def load_playlist(usuario)
    playlist = RepositorioContenido.new.find_playlist_by_usuario(usuario)
    playlist.each do |contenido|
      usuario.agregar_a_playlist(contenido)
    end
  end
end
