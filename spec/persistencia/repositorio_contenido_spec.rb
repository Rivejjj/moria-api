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

  it 'deberia levantar un error cuando la cancion no es encontrada' do
    repo_contenido = described_class.new
    repo_contenido.delete_all
    expect { repo_contenido.find(1) }.to raise_error(CancionNoEncontradaError)
  end

  it 'deberia guardar y asignar id a un podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2024, 360_000, 'ciencia')
    podcast = Podcast.new(info_podcast)
    described_class.new.save(podcast)
    expect(podcast.id).not_to be_nil
  end
end
