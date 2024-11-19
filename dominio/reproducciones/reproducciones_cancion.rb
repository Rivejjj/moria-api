class ReproduccionesCancion
  attr_reader :usuarios

  def initialize(cancion)
    @cancion = cancion
    @usuarios = []
  end

  def agregar_reproduccion_de(usuario)
    @usuarios << usuario
  end
end
