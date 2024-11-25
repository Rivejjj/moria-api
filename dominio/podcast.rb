require_relative './contenido'

class Podcast < Contenido
  attr_reader :episodios

  def initialize(info_podcast, id = nil, created_on = nil)
    super(info_podcast, id, created_on)
    @episodios = []
  end

  def agregar_episodio(episodio)
    @episodios << episodio
  end
end
