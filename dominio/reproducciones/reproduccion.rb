class Reproduccion
  def initialize(usuario, fecha)
    @usuario = usuario
    @fecha = fecha
  end

  def fue_reproducido_hace_menos_de_una_semana?(_proveedor_de_fecha)
    true
  end
end
