require 'spec_helper'
require_relative '../../dominio/me_gustas_usuario'

describe MeGustasUsuario do
  describe 'genero_mas_gustado' do
    it 'deberia devolver el genero mas gustado de un usuario con un me gusta' do
      usuario = instance_double('Usuario')
      me_gustas = [instance_double('Contenido', genero: 'Rock')]
      me_gustas_usuario = described_class.new(usuario, me_gustas)
      expect(me_gustas_usuario.genero_mas_gustado).to eq('Rock')
    end

    it 'deberia devolver el genero mas gustado de un usuario con multiples me gusta' do
      usuario = instance_double('Usuario')
      me_gustas = [instance_double('Contenido', genero: 'Pop'),
                   instance_double('Contenido', genero: 'Pop'),
                   instance_double('Contenido', genero: 'Rock')]
      me_gustas_usuario = described_class.new(usuario, me_gustas)
      expect(me_gustas_usuario.genero_mas_gustado).to eq('Pop')
    end
  end

  describe 'contenido_gustado?' do
    it 'deberia devolver true si tiene me gusta de un contenido particular' do
      usuario = instance_double('Usuario')
      contenido = instance_double('Contenido', es_el_mismo?: true)
      me_gustas_usuario = described_class.new(usuario, [contenido])
      expect(me_gustas_usuario.contenido_gustado?(contenido)).to be true
    end

    it 'deberia devolver false si no tiene me gusta de un contenido particular' do
      usuario = instance_double('Usuario')
      contenido = instance_double('Contenido', es_el_mismo?: false)
      contenido2 = instance_double('Contenido', es_el_mismo?: false)
      me_gustas_usuario = described_class.new(usuario, [contenido])
      expect(me_gustas_usuario.contenido_gustado?(contenido2)).to be false
    end
  end
end
