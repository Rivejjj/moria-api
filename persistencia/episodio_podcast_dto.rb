class EpisodioPodcastDTO
  attr_reader :id_podcast

  def initialize(episodio, id_podcast)
    @episodio = episodio
    @id_podcast = id_podcast
  end

  def numero_episodio
    @episodio.numero_episodio
  end
end
