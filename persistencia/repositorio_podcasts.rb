require_relative './abstract_repository'

class RepositorioPodcasts < AbstractRepository
  TIPO_PODCAST = 'p'.freeze
  self.table_name = :contenido
  self.model_class = 'Podcast'

  protected

  def load_object(a_hash)
    info_podcast = InformacionContenido.new(a_hash[:nombre], a_hash[:autor], a_hash[:anio], a_hash[:duracion], a_hash[:genero])
    Podcast.new(info_podcast, a_hash[:id])
  end

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
