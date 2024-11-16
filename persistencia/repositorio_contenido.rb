require_relative './abstract_repository'

class RepositorioContenido < AbstractRepository
  TIPO_CANCION = 'c'.freeze
  TIPO_PODCAST = 'p'.freeze
  self.table_name = :contenido
  self.model_class = 'Contenido'

  def find(id_contenido)
    fila_contenido = dataset.first(pk_column => id_contenido)
    raise CancionNoEncontradaError if fila_contenido.nil?

    load_object dataset.first(fila_contenido)
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

  def insert(contenido)
    changeset = insert_changeset(contenido)
    changeset[:id] = contenido.id if contenido.id
    id = dataset.insert(changeset)
    contenido.id ||= id
    contenido
  end

  def load_object(a_hash)
    info_contenido = InformacionContenido.new(a_hash[:nombre], a_hash[:autor], a_hash[:anio], a_hash[:duracion], a_hash[:genero])

    Cancion.new(info_contenido, a_hash[:id])
  end

  def changeset(contenido)
    tipo = if contenido.es_una_cancion?
             TIPO_CANCION
           else
             TIPO_PODCAST
           end
    {
      nombre: contenido.nombre,
      autor: contenido.autor,
      anio: contenido.anio,
      duracion: contenido.duracion,
      genero: contenido.genero,
      tipo:
    }
  end
end

class CancionNoEncontradaError < StandardError
end
