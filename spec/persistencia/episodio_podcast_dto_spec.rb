require 'integration_helper'
require_relative '../../persistencia/episodio_podcast_dto'

describe EpisodioPodcastDTO do
  it 'deberia devolver el numero de episodio' do
    episodio_podcast = instance_double('EpisodioPodcast', numero_episodio: 1)
    id_podcast = 1
    episodio_podcast_dto = described_class.new(episodio_podcast, id_podcast)
    expect(episodio_podcast_dto.numero_episodio).to eq 1
  end

  it 'deberia devolver el id del podcast' do
    episodio_podcast = instance_double('EpisodioPodcast')
    id_podcast = 1
    episodio_podcast_dto = described_class.new(episodio_podcast, id_podcast)
    expect(episodio_podcast_dto.id_podcast).to eq 1
  end

  it 'deberia devolver el nombre del episodio' do
    episodio_podcast = instance_double('EpisodioPodcast', nombre: 'Episodio 1')
    id_podcast = 1
    episodio_podcast_dto = described_class.new(episodio_podcast, id_podcast)
    expect(episodio_podcast_dto.nombre).to eq 'Episodio 1'
  end
end
