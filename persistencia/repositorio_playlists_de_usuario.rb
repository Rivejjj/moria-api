class RepositorioPlaylistsDeUsuario
  def save(usuario)
    contenido_nuevo_playlist = filtrar_contenido_nuevo_playlist(usuario)
    max_orden = obtener_max_orden_playlist(usuario)
    insertar_contenido_nuevo(usuario, contenido_nuevo_playlist, max_orden)
  end

  def load(usuario)
    playlist = find_by_usuario(usuario)
    playlist.each do |contenido|
      usuario.agregar_a_playlist(contenido)
    end
  end

  def load_all(usuarios)
    contenidos = RepositorioContenido.new.all
    contenidos = contenidos.map { |contenido| [contenido.id, contenido] }.to_h
    usuarios = usuarios.map { |usuario| [usuario.id, usuario] }.to_h
    agregar_playist_a_usuarios(usuarios, contenidos)
  end

  def delete_all
    dataset.delete
  end

  protected

  def dataset
    DB[:playlists_usuarios_contenido]
  end

  def filtrar_contenido_nuevo_playlist(usuario)
    ids_contenido_playlist_guardada = obtener_ids_contenido_playlist_guardada(usuario)
    usuario.playlist.reject { |contenido| ids_contenido_playlist_guardada.include?(contenido.id) }
  end

  def obtener_ids_contenido_playlist_guardada(usuario)
    dataset.where(id_usuario: usuario.id).select_map(:id_contenido)
  end

  def obtener_max_orden_playlist(usuario)
    dataset.where(id_usuario: usuario.id).max(:orden) || 0
  end

  def insertar_contenido_nuevo(usuario, contenido_nuevo_playlist, max_orden)
    contenido_nuevo_playlist.each_with_index do |contenido, i|
      dataset.insert(
        id_usuario: usuario.id,
        id_contenido: contenido.id,
        orden: max_orden + i + 1
      )
    end
  end

  def find_by_usuario(usuario)
    playlists_usuarios_contenido_filtrado = dataset.where(id_usuario: usuario.id).order(:orden)
    playlist = []
    playlists_usuarios_contenido_filtrado.each do |fila|
      playlist << RepositorioContenido.new.find(fila[:id_contenido])
    end
    playlist
  end

  def agregar_playist_a_usuarios(usuarios, contenidos)
    dataset.each do |fila|
      usuario = usuarios[fila[:id_usuario]]
      contenido = contenidos[fila[:id_contenido]]
      usuario.agregar_a_playlist(contenido)
    end
  end
end
