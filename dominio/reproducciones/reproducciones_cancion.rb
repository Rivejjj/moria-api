require_relative './reproducciones'

class ReproduccionesCancion < Reproducciones
  attr_reader :reproducciones

  def initialize(cancion)
    super(cancion)
    @reproducciones = []
  end

  def agregar_reproduccion_de(usuario)
    @reproducciones << Reproduccion.new(usuario)
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
end

class CancionNoReproducidaError < StandardError; end
