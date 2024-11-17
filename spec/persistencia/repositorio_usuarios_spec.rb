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
    juan = repositorio.get_by_id_plataforma('1')
    expect(juan.nombre).to eq('juan')
    expect(juan.email).to eq('juan@test.com')
    expect(juan.id_plataforma).to eq('1')
  end

  it 'deberia levantar un error cuando el usuario no es encontrado' do
    repositorio = described_class.new
    repositorio.delete_all
    expect { repositorio.get_by_id_plataforma('1') }.to raise_error(UsuarioNoEncontradoError)
  end

  it 'deberia recuperar al usuario con su playlist' do
    cancion = Cancion.new(InformacionContenido.new('cancion', 'autor', 2020, 180, 'rock'))
    RepositorioContenido.new.save(cancion)

    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    juan.agregar_a_playlist(cancion)
    repositorio.save(juan)
    juan = repositorio.find(juan.id)
    expect(juan.tiene_cancion_en_playlist('cancion')).to eq true
  end

  it 'deberia recuperar al usuario con su playlist en orden' do
    cancion1 = guardar_cancion(1)
    cancion2 = guardar_cancion(2)

    juan = Usuario.new('juan', 'juan@test.com', '1')
    agregar_a_playlist_y_guardar(juan, cancion2)
    agregar_a_playlist_y_guardar(juan, cancion1)
    juan = described_class.new.find(juan.id)

    expect(juan.playlist.first.id).to eq cancion2.id
    expect(juan.playlist.last.id).to eq cancion1.id
  end

  it 'deberia recuperar al usuario con sus reproducciones' do
    cancion = Cancion.new(InformacionContenido.new('cancion', 'autor', 2020, 180, 'rock'))
    RepositorioContenido.new.save(cancion)

    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    juan.agregar_reproduccion(cancion)
    repositorio.save(juan)
    juan = repositorio.find(juan.id)
    expect(juan.reproducciones.map(&:id)).to include(cancion.id)
  end

  it 'deberia agregar reproduccion para usuario ya insertado' do
    juan = Usuario.new('juan', 'juan@test.com', '1')

    cancion1 = guardar_cancion_y_agregar_reproduccion(juan, 1)
    cancion2 = guardar_cancion_y_agregar_reproduccion(juan, 2)
    juan = described_class.new.find(juan.id)

    expect(juan.reproducciones.map(&:id)).to include(cancion1.id, cancion2.id)
    expect(juan.reproducciones.length).to eq(2)
  end

  it 'deberia recuperar al usuario con sus me gusta' do
    cancion = Cancion.new(InformacionContenido.new('cancion', 'autor', 2020, 180, 'rock'))
    RepositorioContenido.new.save(cancion)

    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    juan.me_gusta(cancion)
    repositorio.save(juan)
    juan = repositorio.find(juan.id)
    expect(juan.me_gustas.map(&:id)).to include(cancion.id)
  end

  it 'deberia agregar me gusta para usuario ya registrado' do
    juan = Usuario.new('juan', 'juan@test.com', '1')

    cancion1 = guardar_cancion_y_dar_me_gusta(juan, 1)
    cancion2 = guardar_cancion_y_dar_me_gusta(juan, 2)
    juan = described_class.new.find(juan.id)

    expect(juan.me_gustas.map(&:id)).to include(cancion1.id, cancion2.id)
    expect(juan.me_gustas.length).to eq(2)
  end
end

def guardar_cancion(numero_cancion)
  cancion = Cancion.new(InformacionContenido.new("cancion#{numero_cancion}", 'autor', 2020, 180, 'rock'))
  RepositorioContenido.new.save(cancion)
  cancion
end

def agregar_a_playlist_y_guardar(usuario, cancion)
  usuario.agregar_a_playlist(cancion)
  RepositorioUsuarios.new.save(usuario)
end

def guardar_cancion_y_agregar_reproduccion(usuario, numero_cancion)
  cancion = guardar_cancion(numero_cancion)
  usuario.agregar_reproduccion(cancion)
  RepositorioUsuarios.new.save(usuario)
  cancion
end

def guardar_cancion_y_dar_me_gusta(usuario, numero_cancion)
  cancion = guardar_cancion(numero_cancion)
  usuario.me_gusta(cancion)
  RepositorioUsuarios.new.save(usuario)
  cancion
end
