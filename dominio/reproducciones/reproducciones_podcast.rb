require_relative './reproducciones'

class ReproduccionesPodcast < Reproducciones
  attr_reader :reproducciones_episodios

  CANTIDAD_MINIMA_DE_EPISODIOS_REPRODUCIDOS = 2

  def initialize(podcast, reproducciones_episodios)
    super(podcast)
    @reproducciones_episodios = reproducciones_episodios
  end

  def contiene_reproduccion_de?(usuario)
    cantidad_reproducidos = @reproducciones_episodios.count do |reproducciones_episodio|
      reproducciones_episodio.contiene_reproduccion_de?(usuario)
    end
    cantidad_reproducidos >= CANTIDAD_MINIMA_DE_EPISODIOS_REPRODUCIDOS
  end

  def assert_contiene_reproduccion_de(usuario)
    raise PodcastNoReproducidoError unless contiene_reproduccion_de?(usuario)
  end
end

class PodcastNoReproducidoError < StandardError
end
