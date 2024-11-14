class Sistema
  def initialize(repositorio_usuarios, repositorio_contenido, repositorio_podcasts)
    @repositorio_usuarios = repositorio_usuarios
    @repositorio_contenido = repositorio_contenido
    @repositorio_podcasts = repositorio_podcasts
  end

  def crear_usuario(nombre_de_usuario, email, id_plataforma)
    usuario = Usuario.new(nombre_de_usuario, email, id_plataforma)
    raise NombreDeUsuarioEnUsoError unless @repositorio_usuarios.find_by_nombre(nombre_de_usuario).nil?

    @repositorio_usuarios.save(usuario)
    usuario
  end

  def crear_cancion(nombre, autor, anio, duracion, genero)
    info_cancion = InformacionContenido.new(nombre, autor, anio, duracion, genero)
    cancion = Cancion.new(info_cancion)
    @repositorio_contenido.save(cancion)
    cancion.id
  end

  def crear_podcast(nombre, autor, anio, duracion, genero)
    info_podcast = InformacionContenido.new(nombre, autor, anio, duracion, genero)
    podcast = Podcast.new(info_podcast)
    @repositorio_podcasts.save(podcast)
    podcast.id
  end

  def agregar_a_playlist(id_contenido, id_plataforma)
    usuario = @repositorio_usuarios.find_by_id_plataforma(id_plataforma)
    contenido = @repositorio_contenido.find(id_contenido)
    usuario.agregar_a_playlist(contenido)
    @repositorio_usuarios.save(usuario)
    contenido.nombre
  end

  def recomendar_contenido(id_plataforma)
    usuario = @repositorio_usuarios.find_by_id_plataforma(id_plataforma)
    recomendador_de_contenido = RecomendadorDeContenido.new
    contenido_recomendado = recomendador_de_contenido.recomendar_contenido(usuario)
    contenido_recomendado.map { |contenido| [contenido.id, contenido.nombre] }
  end

  def reproducir_cancion(id_contenido, nombre_usuario)
    usuario = @repositorio_usuarios.find_by_nombre(nombre_usuario)
    contenido = @repositorio_contenido.find(id_contenido)
    usuario.agregar_reproduccion(contenido)
    @repositorio_usuarios.save(usuario)
  end

  def dar_me_gusta_a_cancion(id_contenido, id_plataforma)
    usuario = @repositorio_usuarios.find_by_id_plataforma(id_plataforma)
    cancion = @repositorio_contenido.find(id_contenido)
    usuario.me_gusta(cancion)
    @repositorio_usuarios.save(usuario)
  end

  def usuarios
    @repositorio_usuarios.all
  end

  def reset
    @repositorio_usuarios.delete_all
    @repositorio_contenido.delete_all
  end
end

class NombreDeUsuarioEnUsoError < StandardError; end
