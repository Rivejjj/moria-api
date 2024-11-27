require_relative 'presentacion_lista_contenidos'

class PresentacionContenidosDeAutor < PresentacionListaContenidos
  def initialize(contenidos)
    super(contenidos, :contenidos)
  end
end
