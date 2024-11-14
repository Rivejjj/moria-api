class Podcast
  attr_reader :updated_on, :created_on
  attr_accessor :id

  def initialize(info_podcast, id = nil)
    @info_podcast = info_podcast
    @id = id
  end

  def nombre
    @info_podcast.nombre
  end

  def autor
    @info_podcast.autor
  end

  def anio
    @info_podcast.anio
  end

  def duracion
    @info_podcast.duracion
  end

  def genero
    @info_podcast.genero
  end
end
