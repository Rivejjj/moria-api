require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../persistencia/repositorio_usuarios'

describe RepositorioUsuarios do
  it 'deberia guardar y asignar id si el usuario es nuevo' do
    juan = Usuario.new('juan', 'juan@test.com', '1')
    described_class.new.save(juan)
    expect(juan.id).not_to be_nil
  end

  it 'deberia recuperar todos' do
    repositorio = described_class.new
    cantidad_de_usuarios_iniciales = repositorio.all.size
    juan = Usuario.new('juan', 'juan@test.com', '1')
    repositorio.save(juan)
    expect(repositorio.all.size).to be(cantidad_de_usuarios_iniciales + 1)
  end

  it 'deberia recuperar todos los datos del usuario' do
    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    repositorio.save(juan)
    juan = repositorio.find(juan.id)
    expect(juan.nombre).to eq('juan')
    expect(juan.email).to eq('juan@test.com')
    expect(juan.id_plataforma).to eq('1')
  end

  it 'deberia encontrar un usuario por su nombre' do
    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    repositorio.save(juan)
    juan = repositorio.find_by_nombre('juan')
    expect(juan.nombre).to eq('juan')
    expect(juan.email).to eq('juan@test.com')
    expect(juan.id_plataforma).to eq('1')
  end

  it 'deberia encontrar un usuario por su id de plataforma' do
    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    repositorio.save(juan)
    juan = repositorio.find_by_id_plataforma('1')
    expect(juan.nombre).to eq('juan')
    expect(juan.email).to eq('juan@test.com')
    expect(juan.id_plataforma).to eq('1')
  end
end
