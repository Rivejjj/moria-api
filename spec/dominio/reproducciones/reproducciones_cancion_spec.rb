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

  describe 'contiene_reproduccion_de?' do
    it 'deberia devolver true si contiene la reproduccion del usuario' do
      cancion = instance_double('Cancion')
      reproducciones = described_class.new(cancion)

      usuario = instance_double('Usuario', es_el_mismo_usuario_que?: true)
      reproducciones.agregar_reproduccion_de(usuario)

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be true
    end

    it 'deberia devolver false si no contiene la reproduccion del usuario' do
      cancion = instance_double('Cancion')
      reproducciones = described_class.new(cancion)
      usuario = instance_double('Usuario', es_el_mismo_usuario_que?: false)

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be false
    end
  end
end
