require 'spec_helper'
require_relative '../../dominio/me_gustas_contenido'

describe MeGustasContenido do
  describe 'agregar_me_gusta_de' do
    it 'deberia agregar el me gusta de un usuario si reprodujo el contenido' do
      usuario = instance_double('Usuario')

      reproducciones_contenido = instance_double('ReproduccionesContenido', contiene_reproduccion_de?: true)
      me_gustas_contenido = described_class.new(reproducciones_contenido)
      me_gustas_contenido.agregar_me_gusta_de(usuario)

      expect(me_gustas_contenido.usuarios).to include(usuario)
    end
  end
end
