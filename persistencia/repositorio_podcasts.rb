require_relative './abstract_repository'

class RepositorioPodcasts < AbstractRepository
  TIPO_PODCAST = 'p'.freeze
  self.table_name = :contenido
  self.model_class = 'Podcast'

  protected

  def changeset(podcast)
    {
      nombre: podcast.nombre,
      autor: podcast.autor,
      anio: podcast.anio,
      duracion: podcast.duracion,
      genero: podcast.genero,
      tipo: TIPO_PODCAST
    }
  end
end
