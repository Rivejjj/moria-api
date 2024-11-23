require 'spec_helper'
require_relative '../../../dominio/reproducciones/reproducciones_cancion'

describe ReproduccionesCancion do
  describe 'agregar_reproduccion_de' do
    it 'deberia agregar la reproduccion de un usuario' do
      cancion = instance_double('Cancion')
      reproducciones_cancion = described_class.new(cancion)

      reproduccion = instance_double('Usuario')
      reproducciones_cancion.agregar_reproduccion_de(reproduccion)

      expect(reproducciones_cancion.reproducciones[0].usuario).to eq reproduccion
    end
  end

  describe 'contiene_reproduccion_de?' do
    it 'deberia devolver true si contiene la reproduccion del usuario' do
      cancion = instance_double('Cancion')
      reproducciones = described_class.new(cancion)

      usuario = instance_double('Usuario')
      reproduccion = instance_double('Reproduccion', reproducido_por?: true)
      reproducciones.agregar_reproduccion(reproduccion)

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be true
    end

    it 'deberia devolver false si no contiene la reproduccion del usuario' do
      cancion = instance_double('Cancion')
      reproducciones = described_class.new(cancion)
      usuario = instance_double('Usuario')

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be false
    end
  end

  describe 'assert_contiene_reproduccion_de' do
    it 'deberia lanzar una excepcion si no contiene la reproduccion del usuario' do
      usuario = instance_double('Usuario', es_el_mismo_usuario_que?: true)
      cancion = instance_double('Cancion')
      reproducciones = described_class.new(cancion)

      expect { reproducciones.assert_contiene_reproduccion_de(usuario) }.to raise_error(CancionNoReproducidaError)
    end
  end

  describe 'reproducido' do
    it 'deberia obtener el id de la cancion de las reproducciones' do
      cancion = instance_double('Cancion', id: 1)
      reproducciones = described_class.new(cancion)
      expect(reproducciones.reproducido.id).to eq cancion.id
    end
  end
end
