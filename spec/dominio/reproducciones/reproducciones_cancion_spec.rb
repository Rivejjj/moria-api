require 'spec_helper'
require_relative '../../../dominio/reproducciones/reproducciones_cancion'

describe ReproduccionesCancion do
  describe 'agregar_reproduccion_de' do
    it 'deberia agregar la reproduccion de un usuario' do
      cancion = instance_double('Cancion')
      reproducciones = described_class.new(cancion)

      usuario = instance_double('Usuario')
      reproducciones.agregar_reproduccion_de(usuario)

      expect(reproducciones.usuarios).to include(usuario)
    end
  end
end
