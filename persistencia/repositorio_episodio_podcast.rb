require_relative 'repositorio_contenido'

class RepositorioEpisodiosPodcast < AbstractRepository
  self.table_name = :episodios_podcast
  self.model_class = 'EpisodioPodcast'

  def save(episodio)
    repo_contenido = RepositorioContenido.new
    contenido = repo_contenido.find(episodio.id_podcast)
    raise ContenidoNoEncontradoError if contenido.nil? || contenido.es_una_cancion?

    super(episodio)
  end

  def load_object(a_hash)
    EpisodioPodcast.new(a_hash[:numero_episodio], a_hash[:id_podcast], a_hash[:nombre], a_hash[:duracion], a_hash[:id])
  end

  protected

  def changeset(episodio)
    {
      numero_episodio: episodio.numero_episodio,
      id_podcast: episodio.id_podcast,
      nombre: episodio.nombre,
      duracion: episodio.duracion
    }
  end
end
