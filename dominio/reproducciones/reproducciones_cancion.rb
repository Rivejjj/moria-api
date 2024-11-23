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
end

class CancionNoReproducidaError < StandardError; end
