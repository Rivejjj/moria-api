require 'spec_helper'
require_relative '../../dominio/reproducciones_episodio_podcast'

describe ReproduccionesEpisodioPodcast do
  describe 'agregar_reproduccion_de' do
    it 'deberia agregar la reproduccion de un usuario' do
      episodio = instance_double('EpisodioPodcast')
      reproducciones = described_class.new(episodio)

      usuario = instance_double('Usuario')
      reproducciones.agregar_reproduccion_de(usuario)

      expect(reproducciones.usuarios).to include(usuario)
    end
  end

  describe 'contiene_reproduccion_de?' do
    it 'deberia devolver true si contiene la reproduccion del usuario' do
      episodio = instance_double('EpisodioPodcast')
      reproducciones = described_class.new(episodio)

      usuario = instance_double('Usuario')
      reproducciones.agregar_reproduccion_de(usuario)

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be true
    end
  end
end
