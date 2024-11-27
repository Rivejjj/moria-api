require 'spec_helper'
require_relative '../../dominio/usuario'

describe Usuario do
  it 'requiere un nombre de usuario, un email, y un id de plataforma' do
    usuario = described_class.new('nombre', 'email@email.com', '1')
    expect(usuario.nombre).to eq('nombre')
    expect(usuario.email).to eq('email@email.com')
    expect(usuario.id_plataforma).to eq('1')
  end

  it 'puede agregar una cancion a su playlist' do
    usuario = described_class.new('nombre', 'email@email.com', '1')
    cancion = instance_double('Cancion', nombre: 'cancion')
    usuario.agregar_a_playlist(cancion)
    expect(usuario.playlist).to include(cancion)
  end

  it 'dos usuarios con el mismo id deberian considerarse el mismo usuario' do
    usuario1 = described_class.new('nombre', 'email@email.com', '1', 1)
    usuario2 = described_class.new('nombre', 'email@email.com', '1', 1)
    expect(usuario1.es_el_mismo_usuario_que?(usuario2)).to be true
  end
end
