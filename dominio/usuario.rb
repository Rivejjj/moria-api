class Usuario
  attr_reader :nombre, :email, :id_plataforma, :playlist, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, email, id_plataforma, id = nil)
    @id = id
    @nombre = nombre
    @email = email
    @id_plataforma = id_plataforma
    @playlist = []
  end

  def agregar_a_playlist(contenido)
    @playlist << contenido
  end

  def es_el_mismo_usuario_que?(otro_usuario)
    @id == otro_usuario.id
  end
end
