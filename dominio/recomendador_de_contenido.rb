class RecomendadorDeContenido
  ULTIMAS_N_AGREGADAS = 5

  def initialize(repositorio_contenido = nil)
    @repositorio_contenido = repositorio_contenido
  end

  def recomendar_contenido(me_gustas)
    [recomendar_cancion_de_genero_mas_gustado(me_gustas), recomendar_podcast_de_genero_mas_gustado(me_gustas)].compact
  end

  def recomendar_cancion_de_genero_mas_gustado(me_gustas)
    genero = me_gustas.genero_mas_gustado
    canciones = @repositorio_contenido.get_canciones_de_genero(genero)
    recomendacion = buscar_primer_contenido_no_gustado(me_gustas, canciones)
    recomendacion = recomendar_ultima_cancion_no_gustada(me_gustas) if recomendacion.nil?
    recomendacion
  end

  def recomendar_podcast_de_genero_mas_gustado(me_gustas)
    genero = me_gustas.genero_mas_gustado
    podcasts = @repositorio_contenido.get_podcasts_de_genero(genero)
    recomendacion = buscar_primer_contenido_no_gustado(me_gustas, podcasts)
    recomendacion = recomendar_ultima_podcast_no_gustado(me_gustas) if recomendacion.nil?
    recomendacion
  end

  protected

  RANGO_ULTIMOS_CONTENIDOS = 100

  def recomendar_ultima_cancion_no_gustada(me_gustas)
    canciones = @repositorio_contenido.ultimas_canciones(RANGO_ULTIMOS_CONTENIDOS)
    buscar_primer_contenido_no_gustado(me_gustas, canciones)
  end

  def recomendar_ultima_podcast_no_gustado(me_gustas)
    podcasts = @repositorio_contenido.ultimos_podcasts(RANGO_ULTIMOS_CONTENIDOS)
    buscar_primer_contenido_no_gustado(me_gustas, podcasts)
  end

  def buscar_primer_contenido_no_gustado(me_gustas, contenidos)
    contenidos.find { |contenido| !me_gustas.contenido_gustado?(contenido) }
  end
end
