class ReproduccionesPodcast
  def initialize(podcast, reproducciones_episodios)
    @podcast = podcast
    @reproducciones_episodios = reproducciones_episodios
  end

  def contiene_reproduccion_de?(_usuario)
    true
  end
end
