class Contenido
  attr_reader :updated_on, :created_on
  attr_accessor :id

  def initialize(info_contenido, id = nil)
    @info_contenido = info_contenido
    @id = id
  end

  def nombre
    @info_contenido.nombre
  end

  def autor
    @info_contenido.autor
  end

  def anio
    @info_contenido.anio
  end

  def duracion
    @info_contenido.duracion
  end

  def genero
    @info_contenido.genero
  end

  def es_una_cancion?
    false
  end

  def nombre_autor
    autor.nombre
  end
end
