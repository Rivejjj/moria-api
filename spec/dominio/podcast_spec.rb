require 'spec_helper'
require_relative '../../dominio/podcast'
require_relative '../../dominio/informacion_contenido'

describe Podcast do
  it 'requiere informacion del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast).not_to be_nil
  end

  it 'se puede obtener el nombre del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast.nombre).to eq(info_podcast.nombre)
  end
end
