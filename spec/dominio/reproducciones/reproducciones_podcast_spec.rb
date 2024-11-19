require 'spec_helper'
require_relative '../../../dominio/reproducciones/reproducciones_podcast'

describe ReproduccionesPodcast do
  describe 'contiene_reproduccion_de?' do
    it 'deberia devolver true si contiene al menos 2 reproducciones del usuario de episodios' do
      usuario = instance_double('Usuario', es_el_mismo_usuario_que?: true)
      podcast = instance_double('Podcast')
      reprodcciones_episodio1 = instance_double('ReproduccionesEpisodioPodcast', contiene_reproduccion_de?: true)
      reproducciones_episodio2 = instance_double('ReproduccionesEpisodioPodcast', contiene_reproduccion_de?: true)
      reproducciones = described_class.new(podcast, [reprodcciones_episodio1, reproducciones_episodio2])

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be true
    end

    it 'deberia devolver false si no contiene al menos 2 reproducciones del usuario de episodios' do
      usuario = instance_double('Usuario')
      podcast = instance_double('Podcast')
      reproducciones = described_class.new(podcast, [])

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be false
    end
  end

  describe 'assert_contiene_reproduccion_de' do
    it 'deberia lanzar una excepcion si no contiene la reproduccion del usuario' do
      usuario = instance_double('Usuario', es_el_mismo_usuario_que?: true)
      podcast = instance_double('Podcast')
      reproducciones = described_class.new(podcast, [])

      expect { reproducciones.assert_contiene_reproduccion_de(usuario) }.to raise_error(PodcastNoReproducidoError)
    end
  end

  describe 'reproducido' do
    it 'deberia obtener el id de la cancion de las reproducciones' do
      podcast = instance_double('Podcast', id: 1)
      reproducciones = described_class.new(podcast, [])
      expect(reproducciones.reproducido.id).to eq podcast.id
    end
  end
end
