require_relative './abstract_repository'

class RepositorioContenido < AbstractRepository
  self.table_name = :contenido
  self.model_class = 'Cancion'

  def find_playlist_by_usuario(usuario)
    playlists_usuarios_contenido = DB[:playlists_usuarios_contenido]
    playlists_usuarios_contenido_filtrado = playlists_usuarios_contenido.where(id_usuario: usuario.id)
    playlist = []
    playlists_usuarios_contenido_filtrado.each do |fila|
      playlist << find(fila[:id_contenido])
    end
    playlist
  end

  protected

  def load_object(a_hash)
    info_cancion = InformacionCancion.new(a_hash[:nombre], a_hash[:autor], a_hash[:anio], a_hash[:duracion], a_hash[:genero])
    Cancion.new(info_cancion, a_hash[:id])
  end

  def changeset(cancion)
    {
      nombre: cancion.nombre,
      autor: cancion.autor,
      anio: cancion.anio,
      duracion: cancion.duracion,
      genero: cancion.genero
    }
  end
end
