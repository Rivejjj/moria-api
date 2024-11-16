require 'spec_helper'
require_relative '../../dominio/episodio_podcast'

describe EpisodioPodcast do
  it 'requiere informacion de episodio de podcast' do
    numero_episodio = 1
    id_podcast = 1
    nombre = 'Episodio 1'
    duracion = 3600
    cancion = described_class.new(numero_episodio, id_podcast, nombre, duracion)
    expect(cancion).not_to be_nil
  end
end
