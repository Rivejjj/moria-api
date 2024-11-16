require 'spec_helper'
require_relative '../../dominio/episodio_podcast'

describe EpisodioPodcast do
  it 'requiere informacion de episodio de podcast' do
    numero_episodio = 1
    id_podcast = 1
    nombre = 'Episodio 1'
    duracion = 3600
    episodio_podcast = described_class.new(numero_episodio, id_podcast, nombre, duracion)

    expect(episodio_podcast).not_to be_nil
  end
end
