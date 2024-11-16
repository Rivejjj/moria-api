class RepositorioEpisodiosPodcast < AbstractRepository
  self.table_name = :episodios_podcast
  self.model_class = 'EpisodioPodcast'

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
