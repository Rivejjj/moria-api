class ProveedorDeFechaDate
  DIAS_SEMANA = 7
  def en_la_ultima_semana?(fecha)
    fecha > Date.today - DIAS_SEMANA
  end
end
