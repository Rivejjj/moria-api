require 'integration_helper'
require_relative '../../dominio/episodio_podcast'
require_relative '../../persistencia/repositorio_episodio_podcast'

describe RepositorioEpisodiosPodcast do
  autor = Autor.new('autor', '12345678')
  info_contenido = InformacionContenido.new('nombre', autor, 2021, 180, 'genero')
  before(:each) do
    RepositorioContenido.new.delete_all
    described_class.new.delete_all
    RepositorioAutores.new.save(autor)
  end

  it 'deberia guardar y asignar id a un episodio podcast' do
    podcast = Podcast.new(info_contenido, 1)
    RepositorioContenido.new.save(podcast)

    episodio_podcast = EpisodioPodcast.new(1, 'nombre', 180)
    described_class.new.save(episodio_podcast, podcast.id)
    expect(episodio_podcast.id).not_to be_nil
  end

  it 'deberia devolver error al no encontrar el podcast para el episodio' do
    episodio_podcast = EpisodioPodcast.new(1, 'nombre', 180)
    expect { described_class.new.save(episodio_podcast, 1) }.to raise_error(ContenidoNoEncontradoError)
  end

  it 'deberia devolver error al encontrar una cancion en vez de un podcast' do
    cancion = Cancion.new(info_contenido, 1)
    RepositorioContenido.new.save(cancion)

    episodio_podcast = EpisodioPodcast.new(1, 'nombre', 180)
    expect { described_class.new.save(episodio_podcast, 1) }.to raise_error(ContenidoNoEncontradoError)
  end

  it 'deberia guardar y no asignar id a un episodio podcast que ya tiene id' do
    podcast = Podcast.new(info_contenido, 1)
    RepositorioContenido.new.save(podcast)

    episodio_podcast = EpisodioPodcast.new(1, 'nombre', 180, 33)
    described_class.new.save(episodio_podcast, podcast.id)
    expect(described_class.new.find(episodio_podcast.id).id).to eq 33
  end

  it 'deberia cargar los episodios de un podcast' do
    podcast = crear_podcast_con_n_episodios(3, autor)
    podcast2 = crear_podcast_con_n_episodios(2, autor)

    podcast_nuevo = Podcast.new(info_contenido, podcast.id)
    podcast_nuevo2 = Podcast.new(info_contenido, podcast2.id)

    described_class.new.cargar_episodios([podcast_nuevo, podcast_nuevo2])

    expect(podcast_nuevo.episodios.size).to eq 3
    expect(podcast_nuevo2.episodios.size).to eq 2
  end
end

def crear_podcast_con_n_episodios(cantidad_episodios, autor)
  info_contenido = InformacionContenido.new('nombre', autor, 2021, 180, 'genero')
  podcast = Podcast.new(info_contenido)
  cantidad_episodios.times do |i|
    episodio_podcast = EpisodioPodcast.new(i, "nombre#{i}", 180)
    podcast.agregar_episodio(episodio_podcast)
  end
  RepositorioContenido.new.save(podcast)
  podcast
end
