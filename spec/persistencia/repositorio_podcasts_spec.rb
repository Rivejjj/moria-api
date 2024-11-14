require 'integration_helper'
require_relative '../../dominio/podcast'
require_relative '../../dominio/informacion_contenido'
require_relative '../../persistencia/repositorio_podcasts'

describe RepositorioPodcasts do
  it 'deberia guardar y asignar id a un podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2024, 360_000, 'ciencia')
    podcast = Podcast.new(info_podcast)
    described_class.new.save(podcast)
    expect(podcast.id).not_to be_nil
  end
end
