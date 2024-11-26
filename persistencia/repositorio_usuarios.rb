require_relative './abstract_repository'
require_relative './repositorio_playlists_de_usuario'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def save(usuario)
    if find_dataset_by_id(usuario.id).first
      update(usuario)
    else
      insert(usuario)
    end
    RepositorioPlaylistsDeUsuario.new.save(usuario)
    usuario
  end

  def all
    usuarios = dataset.all.map do |fila|
      crear_usuario(fila)
    end
    RepositorioPlaylistsDeUsuario.new.load_all(usuarios)
    usuarios
  end

  def delete_all
    RepositorioPlaylistsDeUsuario.new.delete_all
    dataset.delete
  end

  def find_by_nombre(nombre)
    row = dataset.first(nombre:)
    load_object(row) unless row.nil?
  end

  def get_by_id_plataforma(id_plataforma)
    row = dataset.first(id_plataforma:)
    raise UsuarioNoEncontradoError if row.nil?

    load_object(row)
  end

  protected

  def load_object(a_hash)
    usuario = crear_usuario(a_hash)
    RepositorioPlaylistsDeUsuario.new.load(usuario)
    usuario
  end

  def crear_usuario(a_hash)
    Usuario.new(a_hash[:nombre], a_hash[:email], a_hash[:id_plataforma], a_hash[:id])
  end

  def changeset(usuario)
    {
      nombre: usuario.nombre,
      email: usuario.email,
      id_plataforma: usuario.id_plataforma
    }
  end
end

class UsuarioNoEncontradoError < StandardError; end
