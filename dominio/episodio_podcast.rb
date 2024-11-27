class EpisodioPodcast
  attr_reader :numero_episodio, :nombre, :duracion, :updated_on, :created_on
  attr_accessor :id

  def initialize(numero_episodio, nombre, duracion, id = nil)
    @id = id
    @numero_episodio = numero_episodio
    @nombre = nombre
    @duracion = duracion
  end
end
