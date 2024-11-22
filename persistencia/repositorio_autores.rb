require_relative './abstract_repository'

class RepositorioAutores < AbstractRepository
  self.table_name = :autores
  self.model_class = 'Autor'

  protected

  def changeset(autor)
    {
      nombre: autor.nombre,
      id_externo: autor.id_externo
    }
  end
end
