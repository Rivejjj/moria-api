class Usuario
  attr_reader :nombre, :email, :id_plataforma, :playlist, :reproducciones, :updated_on, :created_on, :me_gustas
  attr_accessor :id

  def initialize(nombre, email, id_plataforma, id = nil)
    @id = id
    @nombre = nombre
    @email = email
    @id_plataforma = id_plataforma
    @playlist = []
    @reproducciones = []
    @me_gustas = []
  end

  def agregar_a_playlist(contenido)
    @playlist << contenido
  end

  def agregar_reproduccion(contenido)
    @reproducciones << contenido
  end

  def tiene_cancion_en_playlist(nombre_cancion)
    @playlist.any? { |cancion| cancion.nombre == nombre_cancion }
  end

  def me_gusta(cancion)
    @me_gustas << cancion
  end

  def reprodujo_la_cancion?(cancion)
    @reproducciones.any? { |reproduccion| reproduccion.id == cancion.id && reproduccion.es_una_cancion? }
  end
end
