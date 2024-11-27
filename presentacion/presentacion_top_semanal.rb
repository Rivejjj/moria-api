require_relative 'presentacion_lista_contenidos'

class PresentacionTopSemanal < PresentacionListaContenidos
  def initialize(contenidos)
    super(contenidos, :top_semanal)
  end
end
