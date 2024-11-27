require_relative 'lista_contenidos_presentacion'

class PresentacionPlaylist < ListaContenidosPresentacion
  def initialize(contenidos)
    super(contenidos, :playlist)
  end
end
