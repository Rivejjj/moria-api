class EpisodioPodcast
  attr_reader :numero_episodio, :id_podcast, :nombre, :duracion, :updated_on, :created_on
  attr_accessor :id

  def initialize(numero_episodio, id_podcast, nombre, duracion, id = nil)
    @id = id
    @numero_episodio = numero_episodio
    @id_podcast = id_podcast
    @nombre = nombre
    @duracion = duracion
  end

  def es_una_cancion?
    false
  end
end
