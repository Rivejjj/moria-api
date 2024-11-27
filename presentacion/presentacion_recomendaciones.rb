require_relative 'presentacion_lista_contenidos'

class PresentacionRecomendaciones < PresentacionListaContenidos
  def initialize(contenidos)
    super(contenidos, :recomendacion)
  end
end
