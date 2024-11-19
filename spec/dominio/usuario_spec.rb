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

  it 'puede verificar si una cancion esta en su playlist' do
    usuario = described_class.new('nombre', 'email@email.com', '1')
    cancion = instance_double('Cancion', nombre: 'cancion')
    usuario.agregar_a_playlist(cancion)
    expect(usuario.tiene_cancion_en_playlist('cancion')).to eq(true)
  end

  it 'puede agregar una reproduccion de cancion' do
    usuario = described_class.new('nombre', 'email@email.com', '1')
    cancion = instance_double('Cancion', nombre: 'cancion')
    usuario.agregar_reproduccion(cancion)
    expect(usuario.reproducciones).to include(cancion)
  end

  it 'puede agregar dos reproduccion de canciones' do
    usuario = described_class.new('nombre', 'email@email.com', '1')
    cancion = instance_double('Cancion', nombre: 'cancion')
    cancion2 = instance_double('Cancion2', nombre: 'cancion2')
    usuario.agregar_reproduccion(cancion)
    usuario.agregar_reproduccion(cancion2)
    expect(usuario.reproducciones).to include(cancion, cancion2)
  end

  it 'reprodujo_la_cancion? deberia devolver true si la reprodujo' do
    usuario = described_class.new('nombre', 'email@email.com', '1')
    cancion = instance_double('Cancion', nombre: 'cancion', id: 1, es_una_cancion?: true)
    usuario.agregar_reproduccion(cancion)
    expect(usuario.reprodujo_la_cancion?(cancion)).to eq(true)
  end

  it 'reprodujo_la_cancion? deberia devolver false si no la reprodujo' do
    usuario = described_class.new('nombre', 'email@email.com', '1')
    cancion1 = instance_double('Cancion', nombre: 'cancion', id: 1, es_una_cancion?: true)
    cancion2 = instance_double('Cancion', nombre: 'cancion', id: 2, es_una_cancion?: true)
    usuario.agregar_reproduccion(cancion1)
    expect(usuario.reprodujo_la_cancion?(cancion2)).to eq(false)
  end

  it 'dos usuarios con el mismo id deberian considerarse el mismo usuario' do
    usuario1 = described_class.new('nombre', 'email@email.com', '1', 1)
    usuario2 = described_class.new('nombre', 'email@email.com', '1', 1)
    expect(usuario1.es_el_mismo_usuario_que?(usuario2)).to be true
  end
end
