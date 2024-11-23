class Reproduccion
  attr_reader :usuario, :fecha

  DIAS_SEMANA = 7

  def initialize(usuario, fecha = nil)
    @usuario = usuario
    @fecha = fecha
  end

  def reproducido_por?(usuario)
    @usuario.es_el_mismo_usuario_que?(usuario)
  end

  def fue_reproducido_hace_menos_de_una_semana?(proveedor_de_fecha)
    @fecha > proveedor_de_fecha.fecha_actual - DIAS_SEMANA
  end
end
