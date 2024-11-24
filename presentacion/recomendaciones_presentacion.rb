require_relative 'lista_contenidos_presentacion'

class RecomendacionesPresentacion < ListaContenidosPresentacion
  def initialize(contenidos)
    super(contenidos, :recomendacion)
  end
end
