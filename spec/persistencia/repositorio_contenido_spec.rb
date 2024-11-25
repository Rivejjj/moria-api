require 'integration_helper'
require_relative '../../dominio/cancion'
require_relative '../../dominio/autor'
require_relative '../../dominio/informacion_contenido'
require_relative '../../persistencia/repositorio_contenido'

describe RepositorioContenido do
  autor = Autor.new('autor', '12345678')
  info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
  info_podcast = InformacionContenido.new('nombre', autor, 2024, 360_000, 'ciencia')
  before(:each) do
    RepositorioAutores.new.save(autor)
  end

  it 'deberia guardar y asignar id a una cancion' do
    cancion = Cancion.new(info_cancion)
    described_class.new.save(cancion)
    expect(cancion.id).not_to be_nil
  end

  it 'deberia levantar un error cuando el contenido no es encontrado' do
    repo_contenido = described_class.new
    repo_contenido.delete_all
    expect { repo_contenido.get(1) }.to raise_error(ContenidoNoEncontradoError)
  end

  it 'deberia guardar y asignar id a un podcast' do
    podcast = Podcast.new(info_podcast)
    described_class.new.save(podcast)
    expect(podcast.id).not_to be_nil
  end

  it 'deberia encontrar un podcast' do
    podcast = Podcast.new(info_podcast)
    repo_contenido = described_class.new
    repo_contenido.save(podcast)
    podcast_encontrado = repo_contenido.first
    expect(podcast_encontrado.es_una_cancion?).to eq(false)
  end

  it 'deberia encontrar un podcast con sus episodios' do
    podcast = Podcast.new(info_podcast)
    episodio = EpisodioPodcast.new(1, 'Episodio 1', 3600)
    podcast.agregar_episodio(episodio)

    repo_contenido = described_class.new
    repo_contenido.save(podcast)

    podcast_encontrado = repo_contenido.get(podcast.id)
    expect(podcast_encontrado.episodios.first.id).to eq(episodio.id)
  end

  it 'deberia encontrar un contenido con su autor' do
    contenido = Cancion.new(info_cancion)
    repo_contenido = described_class.new
    repo_contenido.save(contenido)
    contenido_encontrado = repo_contenido.first
    expect(contenido_encontrado.autor.nombre).to eq 'autor'
    expect(contenido_encontrado.autor.id_externo).to eq '12345678'
  end

  it 'deberia obtener todos los contenidos dada una lista de ids' do
    contenido1 = Cancion.new(info_cancion, 1)
    contenido2 = Cancion.new(info_cancion, 2)
    repo_contenido = described_class.new
    repo_contenido.save(contenido1)
    repo_contenido.save(contenido2)

    contenidos = repo_contenido.get_contenidos([1, 2])
    expect(contenido1.es_el_mismo?(contenidos[0])).to be true
    expect(contenido2.es_el_mismo?(contenidos[1])).to be true
  end

  it 'deberia obtener todas las canciones de un determinado genero' do
    crear_y_guardar_cancion_de_genero('rock', autor)
    crear_y_guardar_cancion_de_genero('rock', autor)
    crear_y_guardar_cancion_de_genero('pop', autor)

    contenidos = described_class.new.get_canciones_de_genero('rock')
    expect(contenidos.all? { |contenido| contenido.genero == 'rock' }).to be true
  end

  it 'deberia obtener todas los podcast de un determinado genero' do
    crear_y_guardar_podcast_de_genero('rock', autor)
    crear_y_guardar_podcast_de_genero('rock', autor)
    crear_y_guardar_podcast_de_genero('pop', autor)

    contenidos = described_class.new.get_podcasts_de_genero('rock')
    expect(contenidos.all? { |contenido| contenido.genero == 'rock' }).to be true
  end

  it 'deberia obtener todos los contenidos de un autor' do
    autor2 = Autor.new('autor2', '23456789')
    RepositorioAutores.new.save(autor2)

    crear_y_guardar_cancion_de_autor(autor)
    crear_y_guardar_podcast_de_autor(autor)
    crear_y_guardar_cancion_de_autor(autor2)

    contenidos = described_class.new.get_contenidos_de_autor(autor)

    expect(contenidos.all? { |contenido| contenido.autor.id == autor.id }).to be true
  end

  it 'deberia obtener el contenido con su fecha de creacion' do
    contenido = Cancion.new(info_cancion)
    described_class.new.save(contenido)

    expect(described_class.new.get(contenido.id).created_on).not_to be nil
  end

  it 'no deberia borrarse la fecha de creacion al actualizar un contenido' do
    contenido = Cancion.new(info_cancion)
    described_class.new.save(contenido)
    contenido = described_class.new.get(contenido.id)
    described_class.new.save(contenido)

    expect(described_class.new.get(contenido.id).created_on).not_to be nil
  end

  it 'Puedo obtener las ultimas canciones' do
    contenido1 = Cancion.new(info_cancion, 1, Date.new(2021, 1, 10))
    contenido2 = Podcast.new(info_podcast, 2, Date.new(2021, 1, 9))
    contenido3 = Cancion.new(info_cancion, 3, Date.new(2021, 1, 8))
    described_class.new.save(contenido1)
    described_class.new.save(contenido2)
    described_class.new.save(contenido3)

    expect(described_class.new.ultimas_canciones(1).map(&:id)).to eq([1])
  end

  it 'Puedo obtener los ultimos podcasts' do
    contenido1 = Podcast.new(info_podcast, 1, Date.new(2021, 1, 10))
    contenido2 = Cancion.new(info_cancion, 2, Date.new(2021, 1, 9))
    contenido3 = Podcast.new(info_podcast, 3, Date.new(2021, 1, 8))
    described_class.new.save(contenido1)
    described_class.new.save(contenido2)
    described_class.new.save(contenido3)

    expect(described_class.new.ultimos_podcasts(1).map(&:id)).to eq([1])
  end
end

def crear_y_guardar_cancion_de_genero(genero, autor)
  info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, genero)
  RepositorioContenido.new.save(Cancion.new(info_cancion))
end

def crear_y_guardar_podcast_de_genero(genero, autor)
  info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, genero)
  podcast = Podcast.new(info_cancion)
  podcast.agregar_episodio(EpisodioPodcast.new(1, 'episodio', 180))
  RepositorioContenido.new.save(podcast)
  podcast
end

def crear_y_guardar_cancion_de_autor(autor)
  info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
  RepositorioContenido.new.save(Cancion.new(info_cancion))
end

def crear_y_guardar_podcast_de_autor(autor)
  info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
  RepositorioContenido.new.save(Podcast.new(info_cancion))
end
