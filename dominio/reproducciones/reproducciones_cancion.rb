class ReproduccionesCancion
  attr_reader :usuarios

  def initialize(cancion)
    @cancion = cancion
    @usuarios = []
  end

  def agregar_reproduccion_de(usuario)
    @usuarios << usuario
  end

  def contiene_reproduccion_de?(_usuario)
    true
  end
end
