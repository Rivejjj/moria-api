require_relative './abstract_repository'

class RepositorioContenido < AbstractRepository
  TIPO_CANCION = 'c'.freeze
  self.table_name = :contenido
  self.model_class = 'Cancion'

  def find(id_contenido)
    fila_cancion = dataset.first(pk_column => id_contenido)
    raise CancionNoEncontradaError if fila_cancion.nil?

    load_object dataset.first(fila_cancion)
  end

  def find_playlist_by_usuario(usuario)
    playlists_usuarios_contenido = DB[:playlists_usuarios_contenido]
    playlists_usuarios_contenido_filtrado = playlists_usuarios_contenido.where(id_usuario: usuario.id).order(:orden)
    playlist = []
    playlists_usuarios_contenido_filtrado.each do |fila|
      playlist << find(fila[:id_contenido])
    end
    playlist
  end

  protected

  def insert(cancion)
    changeset = insert_changeset(cancion)
    changeset[:id] = cancion.id if cancion.id
    id = dataset.insert(changeset)
    cancion.id ||= id
    cancion
  end

  def load_object(a_hash)
    info_cancion = InformacionContenido.new(a_hash[:nombre], a_hash[:autor], a_hash[:anio], a_hash[:duracion], a_hash[:genero])
    Cancion.new(info_cancion, a_hash[:id])
  end

  def changeset(cancion)
    {
      nombre: cancion.nombre,
      autor: cancion.autor,
      anio: cancion.anio,
      duracion: cancion.duracion,
      genero: cancion.genero,
      tipo: TIPO_CANCION
    }
  end
end

class CancionNoEncontradaError < StandardError
end
