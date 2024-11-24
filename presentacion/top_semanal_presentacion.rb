require_relative 'lista_contenidos_presentacion'

class TopSemanalPresentacion < ListaContenidosPresentacion
  def initialize(contenidos)
    super(contenidos, :top_semanal)
  end
end
