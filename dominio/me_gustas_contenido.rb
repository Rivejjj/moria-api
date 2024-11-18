class MeGustasContenido
  attr_reader :usuarios

  def initialize(reproducciones_contenido)
    @reproducciones_contenido = reproducciones_contenido
    @usuarios = []
  end

  def agregar_me_gusta_de(usuario)
    @usuarios << usuario
  end
end
