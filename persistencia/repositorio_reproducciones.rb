class RepositorioReproducciones
  def delete_all
    dataset_reproduciones_episodios.delete
    dataset_reproduciones_canciones.delete
  end

  def save_reproducciones_episodio_podcast(reproducciones_episodio_podcast)
    id_episodio = reproducciones_episodio_podcast.reproducido.id
    reproducciones_episodio_podcast.reproducciones.each do |reproduccion|
      dataset_reproduciones_episodios.insert(add_created_on(id_usuario: reproduccion.usuario.id, id_episodio:))
    end
  end

  def save_reproducciones_cancion(reproducciones_cancion)
    id_contenido = reproducciones_cancion.reproducido.id
    reproducciones_cancion.reproducciones.each do |reproduccion|
      dataset_reproduciones_canciones.insert(add_created_on(id_usuario: reproduccion.usuario.id, id_contenido:))
    end
  end

  def get_reproducciones_episodio_podcast(id_episodio)
    episodio = RepositorioEpisodiosPodcast.new.find(id_episodio)
    reproducciones_episodio_podcast = ReproduccionesEpisodioPodcast.new(episodio)
    reproducciones = dataset_reproduciones_episodios.where(id_episodio:)

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
    reproducciones = dataset_reproduciones_canciones.where(id_contenido:)

    reproducciones.each do |fila|
      usuario = RepositorioUsuarios.new.find(fila[:id_usuario])
      reproducciones_cancion.agregar_reproduccion(Reproduccion.new(usuario, fila[:created_on]))
    end
    reproducciones_cancion
  end

  def all
    contenidos = lista_a_hash_por_id(RepositorioContenido.new.all)
    canciones, podcasts = contenidos.partition { |_, contenido| contenido.is_a?(Cancion) }.map(&:to_h)
    episodios = lista_a_hash_por_id(RepositorioEpisodiosPodcast.new.all)
    usuarios = lista_a_hash_por_id(RepositorioUsuarios.new.all)

    all_reproducciones(canciones, podcasts, episodios, usuarios)
  end

  protected

  def dataset_reproduciones_episodios
    DB[:reproducciones_episodios]
  end

  def dataset_reproduciones_canciones
    DB[:reproducciones_canciones]
  end

  def all_reproducciones(canciones, podcasts, episodios, usuarios)
    all_reproducciones_canciones(canciones, usuarios).values + all_reproducciones_podcasts(podcasts, episodios, usuarios).values
  end

  def all_reproducciones_podcasts(podcasts, episodios, usuarios)
    reproducciones_episodios = all_reproducciones_episodios(episodios, usuarios)
    reproducciones_podcasts = {}

    podcasts.each do |podcast_id, podcast|
      reproducciones_episodios_de_podcast = podcast.episodios.map do |episodio|
        reproducciones_episodios[episodio.id]
      end
      reproducciones_podcasts[podcast_id] = ReproduccionesPodcast.new(podcast, reproducciones_episodios_de_podcast)
    end
    reproducciones_podcasts
  end

  def all_reproducciones_canciones(canciones, usuarios)
    all_reproducciones_de_tipo(dataset_reproduciones_canciones, :id_contenido, canciones, ReproduccionesCancion, usuarios)
  end

  def all_reproducciones_episodios(episodios, usuarios)
    all_reproducciones_de_tipo(dataset_reproduciones_episodios, :id_episodio, episodios, ReproduccionesEpisodioPodcast, usuarios)
  end

  def all_reproducciones_de_tipo(dataset, columna, reproducidos, tipo_reproducciones, usuarios)
    reproducciones = reproducidos.transform_values { |reproducido| tipo_reproducciones.new(reproducido) }

    dataset.each do |fila|
      usuario = usuarios[fila[:id_usuario]]
      reproducciones[fila[columna]].agregar_reproduccion(Reproduccion.new(usuario, fila[:created_on]))
    end
    reproducciones
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def add_created_on(changeset)
    changeset.merge(created_on: Date.today)
  end
end

def lista_a_hash_por_id(lista)
  lista.map { |objeto| [objeto.id, objeto] }.to_h
end
