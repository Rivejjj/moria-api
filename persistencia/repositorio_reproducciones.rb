class RepositorioReproducciones
  def delete_all
    DB[:reproducciones_episodios].delete
  end

  def get_reproducciones_episodio_podcast(id_episodio)
    episodio = RepositorioEpisodiosPodcast.new.find(id_episodio)
    reproducciones_episodio_podcast = ReproduccionesEpisodioPodcast.new(episodio)
    reproducciones = DB[:reproducciones_episodios].where(id_episodio:)

    reproducciones.each do |fila|
      usuario = RepositorioUsuarios.new.find(fila[:id_usuario])
      reproducciones_episodio_podcast.agregar_reproduccion_de(usuario)
    end
    reproducciones_episodio_podcast
  end

  def get_reproducciones_podcast(id_podcast)
    podcast = RepositorioContenido.new.get(id_podcast)
    raise ContenidoNoEncontradoError unless podcast.is_a?(Podcast)

    reproducciones_episodios = []
    podcast.episodios.each do |episodio|
      reproducciones_episodios << get_reproducciones_episodio_podcast(episodio.id)
    end

    ReproduccionesPodcast.new(podcast, reproducciones_episodios)
  end

  def save_reproducciones_episodio_podcast(reproducciones_episodio_podcast)
    id_episodio = reproducciones_episodio_podcast.episodio_podcast.id
    reproducciones_episodio_podcast.usuarios.each do |usuario|
      DB[:reproducciones_episodios].insert(id_usuario: usuario.id, id_episodio:) unless reproduccion_episodio_podcast_ya_existe?(usuario.id, id_episodio)
    end
  end

  protected

  def reproduccion_episodio_podcast_ya_existe?(id_usuario, id_episodio)
    !DB[:reproducciones_episodios].where(id_usuario:, id_episodio:).first.nil?
  end
end
