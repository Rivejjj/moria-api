require_relative './abstract_repository'

class RepositorioAutores < AbstractRepository
  self.table_name = :autores
  self.model_class = 'Autor'

  def get(id_autor)
    fila_autor = dataset.first(pk_column => id_autor)
    raise AutorNoEncontradoError if fila_autor.nil?

    load_object dataset.first(fila_autor)
  end

  def get_by_nombre(nombre)
    fila_autor = dataset.where(Sequel.function(:lower, :nombre) => nombre.downcase).first
    raise AutorNoEncontradoError if fila_autor.nil?

    load_object dataset.first(fila_autor)
  end

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

class AutorNoEncontradoError < StandardError; end
