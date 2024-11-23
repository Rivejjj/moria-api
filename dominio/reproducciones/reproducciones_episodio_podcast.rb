require_relative './reproducciones'

class ReproduccionesEpisodioPodcast < Reproducciones
  attr_reader :reproducciones

  def initialize(episodio_podcast)
    super(episodio_podcast)
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
end
