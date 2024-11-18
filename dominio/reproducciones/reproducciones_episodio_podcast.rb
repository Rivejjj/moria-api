class ReproduccionesEpisodioPodcast
  attr_reader :usuarios, :episodio_podcast

  def initialize(episodio_podcast)
    @episodio_podcast = episodio_podcast
    @usuarios = []
  end

  def agregar_reproduccion_de(usuario)
    @usuarios << usuario
  end

  def contiene_reproduccion_de?(usuario)
    @usuarios.any? { |un_usuario| un_usuario.es_el_mismo_usuario_que?(usuario) }
  end
end
