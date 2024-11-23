require_relative './reproducciones'

class ReproduccionesCancion < Reproducciones
  def agregar_reproduccion_de(usuario)
    agregar_reproduccion(Reproduccion.new(usuario))
  end

  def agregar_reproduccion(reproduccion)
    @reproducciones << reproduccion
  end

  def contiene_reproduccion_de?(usuario)
    @reproducciones.any? { |reproduccion| reproduccion.reproducido_por?(usuario) }
  end

  def assert_contiene_reproduccion_de(usuario)
    raise CancionNoReproducidaError unless contiene_reproduccion_de?(usuario)
  end

  def reproducciones_de_la_semana(proveedor_de_fecha)
    reproducciones_semana = @reproducciones.select { |reproduccion| reproduccion.fue_reproducido_hace_menos_de_una_semana?(proveedor_de_fecha) }

    nuevo = ReproduccionesCancion.new(@cancion)
    reproducciones_semana.each { |reproduccion| nuevo.agregar_reproduccion(reproduccion) }
    nuevo
  end
end

class CancionNoReproducidaError < StandardError; end
