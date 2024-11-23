require 'spec_helper'
require_relative '../../../dominio/reproducciones/reproducciones_episodio_podcast'

describe ReproduccionesEpisodioPodcast do
  describe 'agregar_reproduccion_de' do
    it 'deberia agregar la reproduccion de un usuario' do
      episodio = instance_double('EpisodioPodcast')
      reproducciones_episodio = described_class.new(episodio)

      usuario = instance_double('Usuario')
      reproducciones_episodio.agregar_reproduccion_de(usuario)

      expect(reproducciones_episodio.reproducciones[0].usuario).to eq(usuario)
    end
  end

  describe 'contiene_reproduccion_de?' do
    it 'deberia devolver true si contiene la reproduccion del usuario' do
      episodio = instance_double('EpisodioPodcast')
      reproducciones_episodio = described_class.new(episodio)

      usuario = instance_double('Usuario')
      reproduccion = instance_double('Reproduccion', reproducido_por?: true)
      reproducciones_episodio.agregar_reproduccion(reproduccion)

      expect(reproducciones_episodio.contiene_reproduccion_de?(usuario)).to be true
    end

    it 'deberia devolver false si no contiene la reproduccion del usuario' do
      episodio = instance_double('EpisodioPodcast')
      reproducciones = described_class.new(episodio)
      usuario = instance_double('Usuario', es_el_mismo_usuario_que?: false)

      expect(reproducciones.contiene_reproduccion_de?(usuario)).to be false
    end
  end

  describe 'reproducido' do
    it 'deberia obtener el id del episodio de las reproducciones' do
      episodio = instance_double('EpisodioPodcast', id: 1)
      reproducciones = described_class.new(episodio)
      expect(reproducciones.reproducido.id).to eq episodio.id
    end
  end

  describe 'cantidad_de_reproducciones_de_la_semana' do
    it 'deberia devolver la cantidad de reproducciones de la semana' do
      reproduccion1 = instance_double('Reproduccion', fue_reproducido_hace_menos_de_una_semana?: true)
      reproduccion2 = instance_double('Reproduccion', fue_reproducido_hace_menos_de_una_semana?: false)
      reproduccion3 = instance_double('Reproduccion', fue_reproducido_hace_menos_de_una_semana?: true)

      reproducciones_episodio = described_class.new(instance_double('EpisodioPodcast'))

      reproducciones_episodio.agregar_reproduccion(reproduccion1)
      reproducciones_episodio.agregar_reproduccion(reproduccion2)
      reproducciones_episodio.agregar_reproduccion(reproduccion3)

      expect(reproducciones_episodio.cantidad_de_reproducciones_de_la_semana(instance_double('ProveedorDeFecha'))).to eq 2
    end
  end
end
