require_relative './abstract_repository'

class RepositorioContenido < AbstractRepository
  self.table_name = :contenido
  self.model_class = 'Cancion'

  protected

  def load_object(a_hash)
    Cancion.new(a_hash[:nombre], a_hash[:autor], a_hash[:anio], a_hash[:duracion], a_hash[:genero], a_hash[:id])
  end

  def changeset(cancion)
    {
      nombre: cancion.nombre,
      autor: cancion.autor,
      anio: cancion.anio,
      duracion: cancion.duracion,
      genero: cancion.genero
    }
  end
end
