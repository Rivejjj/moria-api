class RecomendadorDeContenido
  ULTIMAS_N_AGREGADAS = 5

  def initialize(repositorio_contenido = nil)
    @repositorio_contenido = repositorio_contenido
  end

  def recomendar_contenido(usuario)
    usuario.playlist.last(ULTIMAS_N_AGREGADAS).reverse
  end

  def recomendar_cancion_de_genero_mas_gustado(me_gustas)
    genero = me_gustas.genero_mas_gustado
    canciones = @repositorio_contenido.get_canciones_de_genero(genero)
    canciones.find { |cancion| !me_gustas.contenido_gustado?(cancion) }
  end
end
