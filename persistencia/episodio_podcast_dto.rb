class EpisodioPodcastDTO
  attr_reader :id_podcast

  def initialize(episodio, id_podcast)
    @episodio = episodio
    @id_podcast = id_podcast
  end

  def numero_episodio
    @episodio.numero_episodio
  end

  def nombre
    @episodio.nombre
  end

  def duracion
    @episodio.duracion
  end

  def id
    @episodio.id
  end

  def id=(valor)
    @episodio.id = valor
  end

  def created_on
    @episodio.created_on
  end

  def updated_on
    @episodio.updated_on
  end
end
