require 'spec_helper'
require_relative '../../dominio/reproducciones_podcast'

describe ReproduccionesPodcast do
  describe 'contiene_reproduccion_de?' do
    it 'deberia devolver true si contiene la reproduccion del usuario' do
      usuario = instance_double('Usuario', es_el_mismo_usuario_que?: true)
      podcast = instance_double('Podcast')
      reprodcciones_episodio1 = instance_double('ReproduccionesEpisodioPodcast')
      reproducciones_episodio2 = instance_double('ReproduccionesEpisodioPodcast')
      reproducciones = described_class.new(podcast, [reprodcciones_episodio1, reproducciones_episodio2])

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be true
    end
  end
end
