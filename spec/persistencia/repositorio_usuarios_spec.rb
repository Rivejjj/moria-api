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

  it 'deberia recuperar al usuario con su playlist' do
    cancion = Cancion.new(InformacionCancion.new('cancion', 'autor', 2020, 180, 'rock'))
    RepositorioContenido.new.save(cancion)

    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    juan.agregar_a_playlist(cancion)
    repositorio.save(juan)
    juan = repositorio.find(juan.id)
    expect(juan.tiene_cancion_en_playlist('cancion')).to eq true
  end

  it 'deberia recuperar al usuario con sus reproducciones' do
    cancion = Cancion.new(InformacionCancion.new('cancion', 'autor', 2020, 180, 'rock'))
    RepositorioContenido.new.save(cancion)

    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    juan.agregar_reproduccion(cancion)
    repositorio.save(juan)
    juan = repositorio.find(juan.id)
    expect(juan.reproducciones.map(&:id)).to include(cancion.id)
  end

  it 'deberia agregar reproduccion para usuario ya insertado' do
    puts 'aca'
    juan = Usuario.new('juan', 'juan@test.com', '1')

    cancion1 = guardar_cancion(juan, 1)
    cancion2 = guardar_cancion(juan, 2)
    juan = described_class.new.find(juan.id)

    expect(juan.reproducciones.map(&:id)).to include(cancion1.id, cancion2.id)
    expect(juan.reproducciones.length).to eq(2)
  end
end

def guardar_cancion(usuario, numero_cancion)
  repositorio = RepositorioUsuarios.new
  cancion = Cancion.new(InformacionCancion.new("cancion#{numero_cancion}", 'autor', 2020, 180, 'rock'))
  RepositorioContenido.new.save(cancion)
  usuario.agregar_reproduccion(cancion)
  repositorio.save(usuario)
  cancion
end
