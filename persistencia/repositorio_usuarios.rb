require_relative './abstract_repository'

# rubocop:disable Metrics/ClassLength
class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def save(usuario)
    if find_dataset_by_id(usuario.id).first
      update(usuario)
    else
      insert(usuario)
    end
    save_playlist(usuario)
    save_reproducciones(usuario)
    save_me_gustas(usuario)
    usuario
  end

  def delete_all
    DB[:playlists_usuarios_contenido].delete
    DB[:reproducciones].delete
    DB[:me_gustas].delete
    dataset.delete
  end

  def find_by_nombre(nombre)
    row = dataset.first(nombre:)
    load_object(row) unless row.nil?
  end

  def find_by_id_plataforma(id_plataforma)
    row = dataset.first(id_plataforma:)
    raise UsuarioNoEncontradoError if row.nil?

    load_object(row)
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

  def save_reproducciones(usuario)
    reproducciones = DB[:reproducciones]
    usuario.reproducciones.each do |contenido|
      reproducciones.insert(id_usuario: usuario.id, id_contenido: contenido.id) unless cancion_reproducida?(contenido.id, usuario.id)
    end
  end

  def save_me_gustas(usuario)
    me_gustas = DB[:me_gustas]
    usuario.me_gustas.each do |contenido|
      me_gustas.insert(id_usuario: usuario.id, id_contenido: contenido.id)
    end
  end

  def cancion_reproducida?(id_contenido, id_usuario)
    reproducciones = DB[:reproducciones]
    reproducciones_filtrado = reproducciones.where(id_usuario:, id_contenido:)
    !reproducciones_filtrado.first.nil?
  end

  def find_reproducciones(usuario)
    repositorio_contenido = RepositorioContenido.new
    reproducciones = DB[:reproducciones]
    reproducciones_filtrado = reproducciones.where(id_usuario: usuario.id)
    reproducciones = []
    reproducciones_filtrado.each do |fila|
      reproducciones << repositorio_contenido.find(fila[:id_contenido])
    end
    reproducciones
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
    reproducciones = find_reproducciones(usuario)
    reproducciones.each do |contenido|
      usuario.agregar_reproduccion(contenido)
    end
  end

  def load_me_gustas(usuario)
    me_gustas = find_me_gustas(usuario)
    me_gustas.each do |contenido|
      usuario.me_gusta(contenido)
    end
  end

  def load_object(a_hash)
    usuario = Usuario.new(a_hash[:nombre], a_hash[:email], a_hash[:id_plataforma], a_hash[:id])
    load_playlist(usuario)
    load_reproducciones(usuario)
    load_me_gustas(usuario)
    usuario
  end

  def changeset(usuario)
    {
      nombre: usuario.nombre,
      email: usuario.email,
      id_plataforma: usuario.id_plataforma
    }
  end
end
# rubocop:enable Metrics/ClassLength

class UsuarioNoEncontradoError < StandardError; end
