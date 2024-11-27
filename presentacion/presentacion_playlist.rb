require_relative 'presentacion_lista_contenidos'

class PresentacionPlaylist < PresentacionListaContenidos
  def initialize(contenidos)
    super(contenidos, :playlist)
  end
end
