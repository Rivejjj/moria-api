class Sistema
  def initialize(repositorio_usuarios)
    @repositorio_usuarios = repositorio_usuarios
  end

  def crear_usuario(nombre_de_usuario, email, id_plataforma)
    usuario = Usuario.new(nombre_de_usuario, email, id_plataforma)
    raise NombreDeUsuarioEnUsoError unless @repositorio_usuarios.find_by_nombre(nombre_de_usuario).nil?

    @repositorio_usuarios.save(usuario)
    usuario
  end

  def usuarios
    @repositorio_usuarios.all
  end
end

class NombreDeUsuarioEnUsoError < StandardError; end
