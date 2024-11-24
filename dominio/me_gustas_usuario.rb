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

  def contenido_gustado?(otro_contenido)
    @contenidos.any? { |contenido_gustado| contenido_gustado.es_el_mismo?(otro_contenido) }
  end
end
