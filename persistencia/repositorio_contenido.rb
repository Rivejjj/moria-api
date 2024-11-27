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

  def all
    autores = RepositorioAutores.new.all
    load_objects(autores, dataset)
  end

  def get(id_contenido)
    fila_contenido = dataset.first(pk_column => id_contenido)
    raise ContenidoNoEncontradoError if fila_contenido.nil?

    load_object dataset.first(fila_contenido)
  end

  def get_contenidos(ids_contenido)
    load_collection(dataset.where(id: ids_contenido))
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
    load_objects([autor], [a_hash])[0]
  end

  def load_objects(autores, hashes)
    autores = autores.map { |autor| [autor.id, autor] }.to_h
    canciones, podcasts = crear_contenidos(autores, hashes)
    RepositorioEpisodiosPodcast.new.cargar_episodios(podcasts)
    canciones + podcasts
  end

  def crear_contenidos(autores, hashes)
    canciones = []
    podcasts = []
    hashes.each do |a_hash|
      info_contenido = InformacionContenido.new(a_hash[:nombre], autores[a_hash[:id_autor]], a_hash[:anio], a_hash[:duracion], a_hash[:genero])
      case a_hash[:tipo]
      when TIPO_CANCION
        canciones << load_contenido(Cancion, a_hash, info_contenido)
      when TIPO_PODCAST
        podcasts << load_contenido(Podcast, a_hash, info_contenido)
      end
    end
    [canciones, podcasts]
  end

  def load_contenido(tipo_contenido, a_hash, info_contenido)
    tipo_contenido.new(info_contenido, a_hash[:id], a_hash[:created_on])
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
