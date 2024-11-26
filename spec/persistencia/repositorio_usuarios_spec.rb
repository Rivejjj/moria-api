require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../persistencia/repositorio_usuarios'

describe RepositorioUsuarios do
  it 'deberia guardar y asignar id si el usuario es nuevo' do
    juan = Usuario.new('juan', 'juan@test.com', '1')
    described_class.new.save(juan)
    expect(juan.id).not_to be_nil
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
    cancion = guardar_cancion(1)

    repositorio = described_class.new
    juan = Usuario.new('juan', 'juan@test.com', '1')
    juan.agregar_a_playlist(cancion)
    repositorio.save(juan)
    juan = repositorio.find(juan.id)
    expect(juan.tiene_cancion_en_playlist('cancion1')).to eq true
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

  it 'deberia recuperar todos los usuarios' do
    cancion1 = guardar_cancion(1)
    usuario1 = Usuario.new('juan', 'juan@test.com', '1')
    usuario2 = Usuario.new('juan2', 'juan2@test.com', '2')

    agregar_a_playlist_y_guardar(usuario1, cancion1)
    described_class.new.save(usuario2)

    usuarios = described_class.new.all
    expect(usuarios[0].playlist.first.id).to eq cancion1.id
    expect(usuarios.map(&:id)).to include(usuario1.id, usuario2.id)
  end
end

def guardar_cancion(numero_cancion)
  autor = Autor.new('autor', '12345678')
  RepositorioAutores.new.save(autor)
  cancion = Cancion.new(InformacionContenido.new("cancion#{numero_cancion}", autor, 2020, 180, 'rock'))
  RepositorioContenido.new.save(cancion)
  cancion
end

def agregar_a_playlist_y_guardar(usuario, cancion)
  usuario.agregar_a_playlist(cancion)
  RepositorioUsuarios.new.save(usuario)
end
