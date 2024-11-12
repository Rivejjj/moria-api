class RecomendadorDeContenido
  ULTIMAS_N_AGREGADAS = 5

  def recomendar_contenido(usuario)
    usuario.playlist.last(ULTIMAS_N_AGREGADAS).reverse
  end
end
