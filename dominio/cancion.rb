require_relative './contenido'

class Cancion < Contenido
  def es_una_cancion?
    true
  end

  def es_el_mismo?(otro_contenido)
    otro_contenido.id_igual_a?(@id)
  end

  def id_igual_a?(otro_id)
    @id == otro_id
  end
end
