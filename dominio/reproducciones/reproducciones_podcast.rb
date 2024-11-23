require_relative './reproducciones'

class ReproduccionesPodcast < Reproducciones
  CANTIDAD_MINIMA_DE_EPISODIOS_REPRODUCIDOS = 2

  def initialize(podcast, reproducciones_episodios)
    super(podcast)
    @reproducciones = reproducciones_episodios
  end

  def contiene_reproduccion_de?(usuario)
    cantidad_reproducidos = @reproducciones.count do |reproducciones_episodio|
      reproducciones_episodio.contiene_reproduccion_de?(usuario)
    end
    cantidad_reproducidos >= CANTIDAD_MINIMA_DE_EPISODIOS_REPRODUCIDOS
  end

  def assert_contiene_reproduccion_de(usuario)
    raise PodcastNoReproducidoError unless contiene_reproduccion_de?(usuario)
  end

  def reproducciones_de_la_semana(proveedor_de_fecha)
    reproducciones_semana = @reproducciones.map do |reproducciones_episodio|
      reproducciones_episodio.reproducciones_de_la_semana(proveedor_de_fecha)
    end

    self.class.new(@reproducido, reproducciones_semana)
  end
end

class PodcastNoReproducidoError < StandardError
end
