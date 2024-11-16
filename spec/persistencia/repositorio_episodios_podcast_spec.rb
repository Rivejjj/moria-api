require 'integration_helper'
require_relative '../../dominio/episodio_podcast'
require_relative '../../persistencia/repositorio_episodio_podcast'

describe RepositorioEpisodiosPodcast do
  it 'deberia guardar y asignar id a un episodio podcast' do
    episodio_podcast = EpisodioPodcast.new(1, 1, 'nombre', 180)
    described_class.new.save(episodio_podcast)
    expect(episodio_podcast.id).not_to be_nil
  end
end
