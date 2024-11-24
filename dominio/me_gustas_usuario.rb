class MeGustasUsuario
  def initialize(usuario, contenidos)
    @usuario = usuario
    @contenidos = contenidos
  end

  def genero_mas_gustado
    @contenidos.map(&:genero)
               .tally
               .max_by(&:last)
               .first
  end
end
