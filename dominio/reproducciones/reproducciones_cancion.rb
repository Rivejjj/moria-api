require_relative './reproducciones'

class ReproduccionesCancion < Reproducciones
  attr_reader :usuarios

  def initialize(cancion)
    super(cancion)
    @usuarios = []
  end

  def agregar_reproduccion_de(usuario)
    @usuarios << usuario
  end

  def contiene_reproduccion_de?(usuario)
    @usuarios.any? { |un_usuario| un_usuario.es_el_mismo_usuario_que?(usuario) }
  end

  def assert_contiene_reproduccion_de(usuario)
    raise CancionNoReproducidaError unless contiene_reproduccion_de?(usuario)
  end
end

class CancionNoReproducidaError < StandardError; end
