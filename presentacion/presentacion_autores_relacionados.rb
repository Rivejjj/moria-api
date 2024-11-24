class PresentacionAutoresRelacionados
  CANTIDAD_RELACIONADOS = 3

  def initialize(autores_relacionados)
    @autores_relacionados = autores_relacionados
  end

  def obtener_json
    {
      relacionados: @autores_relacionados.relacionados.take(CANTIDAD_RELACIONADOS).map(&:nombre)
    }.to_json
  end
end
