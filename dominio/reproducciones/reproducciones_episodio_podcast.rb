require_relative './reproducciones'

class ReproduccionesEpisodioPodcast < Reproducciones
  def agregar_reproduccion_de(usuario)
    agregar_reproduccion(Reproduccion.new(usuario))
  end

  def agregar_reproduccion(reproduccion)
    @reproducciones << reproduccion
  end

  def contiene_reproduccion_de?(usuario)
    @reproducciones.any? { |reproduccion| reproduccion.reproducido_por?(usuario) }
  end
end
