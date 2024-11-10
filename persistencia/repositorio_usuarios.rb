require_relative './abstract_repository'

class RepositorioUsuarios < AbstractRepository
  self.table_name = :usuarios
  self.model_class = 'Usuario'

  def find_by_nombre(nombre)
    row = dataset.first(nombre:)
    load_object(row) unless row.nil?
  end

  protected

  def load_object(a_hash)
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
