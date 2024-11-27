class PresentacionListaContenidos
  def initialize(contenidos, nombre)
    @contenidos = contenidos
    @nombre = nombre
  end

  def obtener_json
    {
      @nombre => @contenidos.map do |contenido|
        { id_contenido: contenido.id, nombre: contenido.nombre }
      end
    }.to_json
  end
end
