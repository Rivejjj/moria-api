class TopSemanalPresentacion
  def initialize(top_semanal)
    @top_semanal = top_semanal
  end

  def obtener_json
    {
      top_semanal: @top_semanal.map do |contenido|
        { id_contenido: contenido.id, nombre: contenido.nombre }
      end
    }.to_json
  end
end
