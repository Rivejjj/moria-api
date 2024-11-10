class Sistema
  def initialize(repositorio_usuarios, repositorio_contenido)
    @repositorio_usuarios = repositorio_usuarios
    @repositorio_contenido = repositorio_contenido
  end

  def crear_usuario(nombre_de_usuario, email, id_plataforma)
    usuario = Usuario.new(nombre_de_usuario, email, id_plataforma)
    raise NombreDeUsuarioEnUsoError unless @repositorio_usuarios.find_by_nombre(nombre_de_usuario).nil?

    @repositorio_usuarios.save(usuario)
    usuario
  end

  def crear_cancion(nombre, autor, anio, duracion, genero)
    info_cancion = InformacionCancion.new(nombre, autor, anio, duracion, genero)
    cancion = Cancion.new(info_cancion)
    @repositorio_contenido.save(cancion)
    cancion
  end

  def usuarios
    @repositorio_usuarios.all
  end
end

class NombreDeUsuarioEnUsoError < StandardError; end
