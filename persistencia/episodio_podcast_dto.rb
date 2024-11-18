class EpisodioPodcastDTO
  def initialize(episodio, _id_podcast)
    @episodio = episodio
  end

  def numero_episodio
    @episodio.numero_episodio
  end
end
