require 'integration_helper'
require_relative '../../dominio/cancion'
require_relative '../../dominio/informacion_contenido'
require_relative '../../persistencia/repositorio_contenido'

describe RepositorioContenido do
  it 'deberia guardar y asignar id a una cancion' do
    info_cancion = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
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
    info_podcast = InformacionContenido.new('nombre', 'autor', 2024, 360_000, 'ciencia')
    podcast = Podcast.new(info_podcast)
    described_class.new.save(podcast)
    expect(podcast.id).not_to be_nil
  end

  it 'deberia encontrar un podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2024, 360_000, 'ciencia')
    podcast = Podcast.new(info_podcast)
    repo_contenido = described_class.new
    repo_contenido.save(podcast)
    podcast_encontrado = repo_contenido.first
    expect(podcast_encontrado.es_una_cancion?).to eq(false)
  end

  it 'deberia encontrar un podcast con sus episodios' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2024, 360_000, 'ciencia')
    podcast = Podcast.new(info_podcast)
    episodio = EpisodioPodcast.new(1, 'Episodio 1', 3600)
    podcast.agregar_episodio(episodio)

    repo_contenido = described_class.new
    repo_contenido.save(podcast)

    podcast_encontrado = repo_contenido.get(podcast.id)
    expect(podcast_encontrado.episodios.first.id).to eq(episodio.id)
  end

  xit 'deberia encontrar un contenido con su autor' do
    autor = Autor.new('autor', '12345678')
    RepositorioAutores.new.save(autor)
    info_contenido = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
    contenido = Cancion.new(info_contenido)
    described_class.new.save(contenido)
    contenido_encontrado = repo_contenido.first
    expect(contenido_encontrado.autor.nombre).to eq 'autor'
    expect(contenido_encontrado.autor.id_externo).to eq '12345678'
  end
end
