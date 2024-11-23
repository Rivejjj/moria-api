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

  describe 'reproducciones_de_la_semana' do
    it 'deberia devolver las reproducciones de hasta una semana atras' do
      reproduccion1 = instance_double('Reproduccion', fue_reproducido_hace_menos_de_una_semana?: true)
      reproduccion2 = instance_double('Reproduccion', fue_reproducido_hace_menos_de_una_semana?: false)
      reproduccion3 = instance_double('Reproduccion', fue_reproducido_hace_menos_de_una_semana?: true)

      reproducciones_cancion = described_class.new(instance_double('Cancion'))

      reproducciones_cancion.agregar_reproduccion(reproduccion1)
      reproducciones_cancion.agregar_reproduccion(reproduccion2)
      reproducciones_cancion.agregar_reproduccion(reproduccion3)

      expect(reproducciones_cancion.reproducciones_de_la_semana(instance_double('ProveedorDeFecha')).reproducciones).to eq [reproduccion1, reproduccion3]
    end
  end
end
