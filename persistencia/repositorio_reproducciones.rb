class RepositorioReproducciones
  def delete_all
    DB[:reproducciones_episodios].delete
    DB[:reproducciones_canciones].delete
  end

  def save_reproducciones_episodio_podcast(reproducciones_episodio_podcast)
    id_episodio = reproducciones_episodio_podcast.reproducido.id
    reproducciones_episodio_podcast.reproducciones.each do |reproduccion|
      DB[:reproducciones_episodios].insert(add_created_on(id_usuario: reproduccion.usuario.id, id_episodio:))
    end
  end

  def save_reproducciones_cancion(reproducciones_cancion)
    id_contenido = reproducciones_cancion.reproducido.id
    reproducciones_cancion.reproducciones.each do |reproduccion|
      DB[:reproducciones_canciones].insert(add_created_on(id_usuario: reproduccion.usuario.id, id_contenido:))
    end
  end

  def get_reproducciones_episodio_podcast(id_episodio)
    episodio = RepositorioEpisodiosPodcast.new.find(id_episodio)
    reproducciones_episodio_podcast = ReproduccionesEpisodioPodcast.new(episodio)
    reproducciones = DB[:reproducciones_episodios].where(id_episodio:)

    reproducciones.each do |fila|
      usuario = RepositorioUsuarios.new.find(fila[:id_usuario])
      reproducciones_episodio_podcast.agregar_reproduccion(Reproduccion.new(usuario, fila[:created_on]))
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

  def get_reproducciones_cancion(id_contenido)
    cancion = RepositorioContenido.new.get(id_contenido)
    raise ContenidoNoEncontradoError unless cancion.is_a?(Cancion)

    reproducciones_cancion = ReproduccionesCancion.new(cancion)
    reproducciones = DB[:reproducciones_canciones].where(id_contenido:)

    reproducciones.each do |fila|
      usuario = RepositorioUsuarios.new.find(fila[:id_usuario])
      reproducciones_cancion.agregar_reproduccion(Reproduccion.new(usuario, fila[:created_on]))
    end
    reproducciones_cancion
  end

  def all
    contenidos = RepositorioContenido.new.all
    contenidos.map do |contenido|
      case contenido
      when Cancion
        get_reproducciones_cancion(contenido.id)
      when Podcast
        get_reproducciones_podcast(contenido.id)
      end
    end
  end

  protected

  def add_created_on(changeset)
    changeset.merge(created_on: Date.today)
  end
end
