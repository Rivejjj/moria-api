class MeGustasContenido
  attr_reader :reproducciones_contenido, :usuarios

  def initialize(reproducciones_contenido)
    @reproducciones_contenido = reproducciones_contenido
    @usuarios = []
  end

  def agregar_me_gusta_de(usuario)
    @reproducciones_contenido.assert_contiene_reproduccion_de(usuario)
    @usuarios << usuario
  end

  def contenido
    @reproducciones_contenido.reproducido
  end
end
