require_relative './abstract_repository'

class RepositorioAutores < AbstractRepository
  self.table_name = :autores
  self.model_class = 'Autor'

  protected

  def load_object(a_hash)
    Autor.new(a_hash[:nombre], a_hash[:id_externo], a_hash[:id])
  end

  def changeset(autor)
    {
      nombre: autor.nombre,
      id_externo: autor.id_externo
    }
  end
end
