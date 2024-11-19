require 'spec_helper'
require_relative '../../dominio/me_gustas_contenido'

describe MeGustasContenido do
  describe 'agregar_me_gusta_de' do
    it 'deberia agregar el me gusta de un usuario si reprodujo el contenido' do
      usuario = instance_double('Usuario')

      reproducciones_contenido = instance_double('ReproduccionesContenido', assert_contiene_reproduccion_de: nil)
      me_gustas_contenido = described_class.new(reproducciones_contenido)
      me_gustas_contenido.agregar_me_gusta_de(usuario)

      expect(me_gustas_contenido.usuarios).to include(usuario)
    end

    it 'deberia lanzar una excepcion si el usuario no reprodujo el podcast' do
      usuario = instance_double('Usuario')

      reproducciones_contenido = instance_double('ReproduccionesContenido')
      allow(reproducciones_contenido).to receive(:assert_contiene_reproduccion_de).and_raise(PodcastNoReproducidoError)
      me_gustas_contenido = described_class.new(reproducciones_contenido)

      expect { me_gustas_contenido.agregar_me_gusta_de(usuario) }.to raise_error(PodcastNoReproducidoError)
    end
  end

  describe 'contenido' do
    it 'deberia devolver el contenido' do
      contenido = instance_double('Contenido')
      reproducciones_contenido = instance_double('ReproduccionesContenido', reproducido: contenido)
      me_gustas_contenido = described_class.new(reproducciones_contenido)
      expect(me_gustas_contenido.contenido).to eq(contenido)
    end
  end
end
