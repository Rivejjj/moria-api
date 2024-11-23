class Reproduccion
  DIAS_SEMANA = 7

  def initialize(usuario, fecha)
    @usuario = usuario
    @fecha = fecha
  end

  def fue_reproducido_hace_menos_de_una_semana?(proveedor_de_fecha)
    @fecha > proveedor_de_fecha.fecha_actual - DIAS_SEMANA
  end
end
