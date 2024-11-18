class ReproduccionesEpisodioPodcast
  attr_reader :usuarios

  def initialize(episodio_podcast)
    @episodio_podcast = episodio_podcast
    @usuarios = []
  end

  def agregar_reproduccion_de(usuario)
    @usuarios << usuario
  end
end
