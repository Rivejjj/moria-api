require 'spec_helper'
require_relative '../../dominio/usuario'

describe Usuario do
  it 'requiere un nombre de usuario, un email, y un id de plataforma' do
    usuario = described_class.new('nombre', 'email@email.com', 141_733_544)
    expect(usuario.nombre).to eq('nombre')
    expect(usuario.email).to eq('email@email.com')
    expect(usuario.id_plataforma).to eq(141_733_544)
  end
end
