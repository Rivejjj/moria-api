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
end
