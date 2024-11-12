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
    save_reproducciones(usuario)
    usuario
  end

  def delete_all
    DB[:playlists_usuarios_contenido].delete
    DB[:reproducciones].delete
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

  def save_reproducciones(usuario)
    reproducciones = DB[:reproducciones]
    usuario.reproducciones.each do |contenido|
      reproducciones.insert(id_usuario: usuario.id, id_contenido: contenido.id)
    end
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

  def load_object(a_hash)
    usuario = Usuario.new(a_hash[:nombre], a_hash[:email], a_hash[:id_plataforma], a_hash[:id])
    load_playlist(usuario)
    load_reproducciones(usuario)
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
