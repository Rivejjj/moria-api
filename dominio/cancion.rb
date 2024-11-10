class Cancion
  attr_reader :updated_on, :created_on
  attr_accessor :id

  def initialize(info_cancion, id = nil)
    @info_cancion = info_cancion
    @id = id
  end

  def nombre
    @info_cancion.nombre
  end

  def autor
    @info_cancion.autor
  end

  def anio
    @info_cancion.anio
  end

  def duracion
    @info_cancion.duracion
  end

  def genero
    @info_cancion.genero
  end
end
