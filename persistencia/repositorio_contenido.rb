require_relative './abstract_repository'

class RepositorioContenido < AbstractRepository
  TIPO_CANCION = 'c'.freeze
  TIPO_PODCAST = 'p'.freeze
  self.table_name = :contenido
  self.model_class = 'Contenido'

  def save(contenido)
    RepositorioAutores.new.get(contenido.autor.id)
    super(contenido)
    if contenido.is_a?(Podcast)
      contenido.episodios.each do |episodio|
        RepositorioEpisodiosPodcast.new.save(episodio, contenido.id)
      end
    end
  end

  def get(id_contenido)
    fila_contenido = dataset.first(pk_column => id_contenido)
    raise ContenidoNoEncontradoError if fila_contenido.nil?

    load_object dataset.first(fila_contenido)
  end

  def get_contenidos(ids_contenido)
    load_collection(dataset.where(id: ids_contenido))
  end

  def find_playlist_by_usuario(usuario)
    playlists_usuarios_contenido = DB[:playlists_usuarios_contenido]
    playlists_usuarios_contenido_filtrado = playlists_usuarios_contenido.where(id_usuario: usuario.id).order(:orden)
    playlist = []
    playlists_usuarios_contenido_filtrado.each do |fila|
      playlist << find(fila[:id_contenido])
    end
    playlist
  end

  def get_canciones_de_genero(genero)
    get_contenido_de_genero(genero, TIPO_CANCION)
  end

  def get_podcasts_de_genero(genero)
    get_contenido_de_genero(genero, TIPO_PODCAST)
  end

  def get_contenidos_de_autor(autor)
    dataset.where(id_autor: autor.id).map { |fila| load_object(fila) }
  end

  def ultimas_canciones(cantidad)
    ultimos_contenidos(TIPO_CANCION, cantidad)
  end

  def ultimos_podcasts(cantidad)
    ultimos_contenidos(TIPO_PODCAST, cantidad)
  end

  protected

  def ultimos_contenidos(tipo_contenido, cantidad)
    load_collection(dataset.where(tipo: tipo_contenido).order(Sequel.desc(:created_on)).limit(cantidad).all)
  end

  def get_contenido_de_genero(genero, tipo_contenido)
    contenido_de_genero = dataset.where(genero:, tipo: tipo_contenido)
    load_collection(contenido_de_genero)
  end

  def insert(contenido)
    changeset = insert_changeset(contenido)
    changeset[:id] = contenido.id if contenido.id
    id = dataset.insert(changeset)
    contenido.id ||= id
    contenido
  end

  def load_object(a_hash)
    autor = RepositorioAutores.new.get(a_hash[:id_autor])
    info_contenido = InformacionContenido.new(a_hash[:nombre], autor, a_hash[:anio], a_hash[:duracion], a_hash[:genero])
    case a_hash[:tipo]
    when TIPO_CANCION
      load_cancion(a_hash, info_contenido)
    when TIPO_PODCAST
      load_podcast(a_hash, info_contenido)
    end
  end

  def load_cancion(a_hash, info_contenido)
    Cancion.new(info_contenido, a_hash[:id], a_hash[:created_on])
  end

  def load_podcast(a_hash, info_contenido)
    podcast = Podcast.new(info_contenido, a_hash[:id], a_hash[:created_on])
    episodios = RepositorioEpisodiosPodcast.new.find_by_id_podcast(a_hash[:id])
    episodios.each do |episodio|
      podcast.agregar_episodio(episodio)
    end
    podcast
  end

  def changeset(contenido)
    tipo = if contenido.es_una_cancion?
             TIPO_CANCION
           else
             TIPO_PODCAST
           end
    {
      nombre: contenido.nombre,
      id_autor: contenido.autor.id,
      anio: contenido.anio,
      duracion: contenido.duracion,
      genero: contenido.genero,
      created_on: contenido.created_on,
      tipo:
    }
  end
end

class ContenidoNoEncontradoError < StandardError
end
