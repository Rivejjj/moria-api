require 'spec_helper'
require_relative '../../persistencia/repositorio_playlists_de_usuario'

describe RepositorioPlaylistsDeUsuario do
  it 'deberia recuperar todas las playlists de usuarios' do
    usuario1, cancion1 = crear_usuario_con_una_cancion_en_playlist('juan')
    usuario2, cancion2 = crear_usuario_con_una_cancion_en_playlist('juan2')

    usuario_nuevo1 = Usuario.new('juan', 'juan', '1', usuario1.id)
    usuario_nuevo2 = Usuario.new('juan2', 'juan', '2', usuario2.id)
    described_class.new.load_all([usuario_nuevo1, usuario_nuevo2])
    expect(usuario_nuevo1.playlist.map(&:id)).to eq [cancion1.id]
    expect(usuario_nuevo2.playlist.map(&:id)).to eq [cancion2.id]
  end
end

def crear_usuario_con_una_cancion_en_playlist(nombre)
  autor = Autor.new('fito', '1')
  RepositorioAutores.new.save(autor)
  usuario = Usuario.new(nombre, 'juan', '1')
  cancion = Cancion.new(InformacionContenido.new('cancion', autor, 1978, 206, 'rock'))
  RepositorioContenido.new.save(cancion)
  usuario.agregar_a_playlist(cancion)
  RepositorioUsuarios.new.save(usuario)
  [usuario, cancion]
end
