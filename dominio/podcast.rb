require_relative './contenido'

class Podcast < Contenido
  def tipo_contenido
    :podcast
  end
end
