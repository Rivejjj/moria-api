require_relative './contenido'

class Cancion < Contenido
  def es_una_cancion?
    true
  end

  def es_el_mismo?(_otro_contenido)
    true
  end
end
