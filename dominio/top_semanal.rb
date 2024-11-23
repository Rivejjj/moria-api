class TopSemanal
  def initialize(repositorio_reproducciones, proveedor_de_fecha)
    @repositorio_reproducciones = repositorio_reproducciones
    @proveedor_de_fecha = proveedor_de_fecha
  end

  def obtener_contenidos
    top = @repositorio_reproducciones.all.sort_by do |reproduccion|
      - reproduccion.cantidad_de_reproducciones_de_la_semana(@proveedor_de_fecha)
    end.first(3)
    top.map(&:reproducido)
  end
end
