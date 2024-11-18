class ReproduccionesCancion
  attr_reader :cancion, :usuarios

  def initialize(cancion)
    @cancion = cancion
    @usuarios = []
  end

  def agregar_reproduccion_de(usuario)
    @usuarios << usuario
  end

  def contiene_reproduccion_de?(usuario)
    @usuarios.any? { |un_usuario| un_usuario.es_el_mismo_usuario_que?(usuario) }
  end
end
