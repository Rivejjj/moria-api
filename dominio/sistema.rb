class Sistema
  def initialize(configuracion_repositorios)
    @repositorio_usuarios = configuracion_repositorios.repositorio_usuarios
    @repositorio_contenido = configuracion_repositorios.repositorio_contenido
    @repositorio_episodios = configuracion_repositorios.repositorio_episodios
    @repositorio_me_gustas_contenido = configuracion_repositorios.repositorio_me_gustas_contenido
    @repositorio_reproducciones = configuracion_repositorios.repositorio_reproducciones
    @repositorio_autores = configuracion_repositorios.repositorio_autores
  end

  def crear_usuario(nombre_de_usuario, email, id_plataforma)
    usuario = Usuario.new(nombre_de_usuario, email, id_plataforma)
    raise NombreDeUsuarioEnUsoError unless @repositorio_usuarios.find_by_nombre(nombre_de_usuario).nil?

    @repositorio_usuarios.save(usuario)
    usuario
  end

  def crear_cancion(nombre, nombre_autor, anio, duracion, genero)
    autor = @repositorio_autores.get_by_nombre(nombre_autor)
    info_cancion = InformacionContenido.new(nombre, autor, anio, duracion, genero)
    cancion = Cancion.new(info_cancion)
    @repositorio_contenido.save(cancion)
    cancion.id
  end

  def crear_podcast(nombre, nombre_autor, anio, duracion, genero)
    autor = @repositorio_autores.get_by_nombre(nombre_autor)
    info_podcast = InformacionContenido.new(nombre, autor, anio, duracion, genero)
    podcast = Podcast.new(info_podcast)
    @repositorio_contenido.save(podcast)
    podcast.id
  end

  def agregar_a_playlist(id_contenido, id_plataforma)
    usuario = @repositorio_usuarios.get_by_id_plataforma(id_plataforma)
    contenido = @repositorio_contenido.get(id_contenido)
    usuario.agregar_a_playlist(contenido)
    @repositorio_usuarios.save(usuario)
    contenido.nombre
  end

  def recomendar_contenido(id_plataforma)
    usuario = @repositorio_usuarios.get_by_id_plataforma(id_plataforma)
    recomendador_de_contenido = RecomendadorDeContenido.new
    contenido_recomendado = recomendador_de_contenido.recomendar_contenido(usuario)
    contenido_recomendado.map { |contenido| [contenido.id, contenido.nombre] }
  end

  def reproducir_cancion(id_contenido, nombre_usuario)
    usuario = @repositorio_usuarios.find_by_nombre(nombre_usuario)
    reproducciones_cancion = @repositorio_reproducciones.get_reproducciones_cancion(id_contenido)
    reproducciones_cancion.agregar_reproduccion_de(usuario)
    @repositorio_reproducciones.save_reproducciones_cancion(reproducciones_cancion)
  end

  def reproducir_episodio_podcast(id_episodio, nombre_usuario)
    usuario = @repositorio_usuarios.find_by_nombre(nombre_usuario)
    reproducciones_episodio_podcast = @repositorio_reproducciones.get_reproducciones_episodio_podcast(id_episodio)
    reproducciones_episodio_podcast.agregar_reproduccion_de(usuario)
    @repositorio_reproducciones.save_reproducciones_episodio_podcast(reproducciones_episodio_podcast)
    reproducciones_episodio_podcast.reproducido.id
  end

  def dar_me_gusta_a_contenido(id_contenido, id_plataforma)
    usuario = @repositorio_usuarios.get_by_id_plataforma(id_plataforma)
    me_gustas_contenido = @repositorio_me_gustas_contenido.get(id_contenido)
    me_gustas_contenido.agregar_me_gusta_de(usuario)
    @repositorio_me_gustas_contenido.save(me_gustas_contenido)
  end

  def crear_episodio_podcast(id_podcast, numero_episodio, nombre, duracion)
    podcast = @repositorio_contenido.get(id_podcast)
    episodio = EpisodioPodcast.new(numero_episodio, nombre, duracion)
    podcast.agregar_episodio(episodio)
    @repositorio_contenido.save(podcast)
    episodio.id
  end

  def obtener_detalles_contenido(id_contenido)
    contenido = @repositorio_contenido.get(id_contenido)
    DetallesContenido.new(contenido)
  end

  def crear_autor(nombre, id_externo)
    autor = Autor.new(nombre, id_externo)
    @repositorio_autores.save(autor)
    autor.id
  end

  def usuarios
    @repositorio_usuarios.all
  end

  def reset
    @repositorio_me_gustas_contenido.delete_all
    @repositorio_reproducciones.delete_all
    @repositorio_usuarios.delete_all
    @repositorio_contenido.delete_all
    @repositorio_episodios.delete_all
    @repositorio_autores.delete_all
  end
end

class NombreDeUsuarioEnUsoError < StandardError; end
