require_relative 'repositorio_contenido'

class RepositorioEpisodiosPodcast < AbstractRepository
  self.table_name = :episodios_podcast
  self.model_class = 'EpisodioPodcast'

  def save(episodio, id_podcast)
    repo_contenido = RepositorioContenido.new
    contenido = repo_contenido.get(id_podcast)
    raise ContenidoNoEncontradoError if contenido.es_una_cancion?

    if find_dataset_by_id(episodio.id).first
      update(episodio, id_podcast)
    else
      insert(episodio, id_podcast)
    end
    episodio
  end

  def find_by_id_podcast(id_podcast)
    dataset.where(id_podcast:).map { |row| load_object(row) }
  end

  protected

  def insert(episodio, id_podcast)
    changeset = insert_changeset(episodio, id_podcast)
    changeset[:id] = episodio.id if episodio.id
    id = dataset.insert(changeset)
    episodio.id ||= id
    episodio
  end

  def update(episodio, id_podcast)
    find_dataset_by_id(episodio.id).update(update_changeset(episodio, id_podcast))
  end

  def insert_changeset(episodio, id_podcast)
    add_id_podcast(super(episodio), id_podcast)
  end

  def update_changeset(episodio, id_podcast)
    add_id_podcast(super(episodio), id_podcast)
  end

  def add_id_podcast(changeset, id_podcast)
    changeset.merge(id_podcast:)
  end

  def load_object(a_hash)
    EpisodioPodcast.new(a_hash[:numero_episodio], a_hash[:nombre], a_hash[:duracion], a_hash[:id])
  end

  def changeset(episodio)
    {
      numero_episodio: episodio.numero_episodio,
      nombre: episodio.nombre,
      duracion: episodio.duracion
    }
  end
end
