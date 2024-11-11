require_relative './abstract_repository'

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
    usuario
  end

  def delete_all
    DB[:playlists_usuarios_contenido].delete
    dataset.delete
  end

  def find_by_nombre(nombre)
    row = dataset.first(nombre:)
    load_object(row) unless row.nil?
  end

  def find_by_id_plataforma(id_plataforma)
    row = dataset.first(id_plataforma:)
    load_object(row) unless row.nil?
  end

  protected

  def save_playlist(usuario)
    playlists_usuarios_contenido = DB[:playlists_usuarios_contenido]
    playlist_vieja = playlists_usuarios_contenido.where(id_usuario: usuario.id)
    playlist_vieja.delete

    usuario.playlist.each do |contenido|
      playlists_usuarios_contenido.insert(id_usuario: usuario.id, id_contenido: contenido.id)
    end
  end

  def load_object(a_hash)
    usuario = Usuario.new(a_hash[:nombre], a_hash[:email], a_hash[:id_plataforma], a_hash[:id])
    playlist = RepositorioContenido.new.find_playlist_by_usuario(usuario)
    playlist.each do |contenido|
      usuario.agregar_a_playlist(contenido)
    end
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
