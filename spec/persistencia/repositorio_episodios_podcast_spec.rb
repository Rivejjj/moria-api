require 'integration_helper'
require_relative '../../dominio/episodio_podcast'
require_relative '../../persistencia/repositorio_episodio_podcast'

describe RepositorioEpisodiosPodcast do
  before(:each) do
    RepositorioContenido.new.delete_all
    described_class.new.delete_all
  end

  it 'deberia guardar y asignar id a un episodio podcast' do
    info_contenido = InformacionContenido.new('nombre', 'autor', 2021, 180, 'genero')
    podcast = Podcast.new(info_contenido, 1)
    RepositorioContenido.new.save(podcast)

    episodio_podcast = EpisodioPodcast.new(1, podcast.id, 'nombre', 180)
    described_class.new.save(episodio_podcast)
    expect(episodio_podcast.id).not_to be_nil
  end

  it 'deberia devoler error al no encontrar el podcast para el episodio' do
    episodio_podcast = EpisodioPodcast.new(1, 1, 'nombre', 180)
    expect { described_class.new.save(episodio_podcast) }.to raise_error(ContenidoNoEncontradoError)
  end

  it 'deberia devolver error al encontrar una cancion en vez de un podcast' do
    info_contenido = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    cancion = Cancion.new(info_contenido, 1)
    RepositorioContenido.new.save(cancion)

    episodio_podcast = EpisodioPodcast.new(1, 1, 'nombre', 180)
    expect { described_class.new.save(episodio_podcast) }.to raise_error(ContenidoNoEncontradoError)
  end

  it 'deberia guardar y no asignar id a un episodio podcast que ya tiene id' do
    info_contenido = InformacionContenido.new('nombre', 'autor', 2021, 180, 'genero')
    podcast = Podcast.new(info_contenido, 1)
    RepositorioContenido.new.save(podcast)

    episodio_podcast = EpisodioPodcast.new(1, podcast.id, 'nombre', 180, 33)
    described_class.new.save(episodio_podcast)
    expect(described_class.new.find(episodio_podcast.id).id).to eq 33
  end
end
