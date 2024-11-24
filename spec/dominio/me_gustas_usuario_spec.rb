require 'spec_helper'
require_relative '../../dominio/me_gustas_usuario'

describe MeGustasUsuario do
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
