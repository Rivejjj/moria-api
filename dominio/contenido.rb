class Contenido
  attr_reader :updated_on, :created_on
  attr_accessor :id

  def initialize(info_contenido, id = nil, created_on = nil)
    @created_on = created_on
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

  def es_el_mismo?(otro_contenido)
    otro_contenido.id_igual_a?(@id)
  end

  def id_igual_a?(otro_id)
    @id == otro_id
  end

  def nombre_autor
    autor.nombre
  end
end
