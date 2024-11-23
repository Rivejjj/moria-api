require_relative './reproducciones'

class ReproduccionesCancion < Reproducciones
  def agregar_reproduccion_de(usuario)
    agregar_reproduccion(Reproduccion.new(usuario))
  end

  def contiene_reproduccion_de?(usuario)
    @reproducciones.any? { |reproduccion| reproduccion.reproducido_por?(usuario) }
  end

  def assert_contiene_reproduccion_de(usuario)
    raise CancionNoReproducidaError unless contiene_reproduccion_de?(usuario)
  end

  def cantidad_de_reproducciones
    @reproducciones.size
  end

  def cantidad_de_reproducciones_de_la_semana(proveedor_de_fecha)
    reproducciones_de_la_semana(proveedor_de_fecha).cantidad_de_reproducciones
  end
end

class CancionNoReproducidaError < StandardError; end
