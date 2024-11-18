require_relative 'repositorio_contenido'

class RepositorioEpisodiosPodcast < AbstractRepository
  self.table_name = :episodios_podcast
  self.model_class = 'EpisodioPodcast'

  def save(episodio, id_podcast)
    repo_contenido = RepositorioContenido.new
    contenido = repo_contenido.get(id_podcast)
    raise ContenidoNoEncontradoError if contenido.es_una_cancion?

    episodio_podcast_dto = EpisodioPodcastDTO.new(episodio, id_podcast)
    super(episodio_podcast_dto)
  end

  def find_by_id_podcast(id_podcast)
    dataset.where(id_podcast:).map { |row| load_object(row) }
  end

  protected

  def insert(episodio)
    changeset = insert_changeset(episodio)
    changeset[:id] = episodio.id if episodio.id
    id = dataset.insert(changeset)
    episodio.id ||= id
    episodio
  end

  def load_object(a_hash)
    EpisodioPodcast.new(a_hash[:numero_episodio], a_hash[:nombre], a_hash[:duracion], a_hash[:id])
  end

  def changeset(episodio)
    {
      numero_episodio: episodio.numero_episodio,
      id_podcast: episodio.id_podcast,
      nombre: episodio.nombre,
      duracion: episodio.duracion
    }
  end
end
