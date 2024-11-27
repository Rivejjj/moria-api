require 'spec_helper'
require_relative '../../dominio/episodio_podcast'

describe EpisodioPodcast do
  numero_episodio = 1
  nombre = 'Episodio 1'
  duracion = 3600

  it 'requiere informacion de episodio de podcast' do
    episodio_podcast = described_class.new(numero_episodio, nombre, duracion)

    expect(episodio_podcast).not_to be_nil
  end
end
