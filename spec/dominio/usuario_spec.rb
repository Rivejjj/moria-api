require 'spec_helper'
require_relative '../../dominio/usuario'

describe Usuario do
  it 'requiere un nombre de usuario, un email, y un id de plataforma' do
    usuario = described_class.new('nombre', 'email@email.com', 141_733_544)
    expect(usuario.nombre).to eq('nombre')
    expect(usuario.email).to eq('email@email.com')
    expect(usuario.id_plataforma).to eq(141_733_544)
  end

  it 'puede agregar una cancion a su playlist' do
    usuario = described_class.new('nombre', 'email@email.com', 141_733_544)
    cancion = instance_double('Cancion', nombre: 'cancion')
    usuario.agregar_a_playlist(cancion)
    expect(usuario.playlist).to include(cancion)
  end
end
