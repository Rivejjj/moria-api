require_relative 'lista_contenidos_presentacion'

class PresentacionContenidosDeAutor < ListaContenidosPresentacion
  def initialize(contenidos)
    super(contenidos, :contenidos)
  end
end
