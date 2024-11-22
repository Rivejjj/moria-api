class DetallesContenido
  def initialize(contenido)
    @contenido = contenido
  end

  def obtener_json
    if @contenido.is_a? Cancion
      obtener_json_cancion
    elsif @contenido.is_a? Podcast
      obtener_json_podcast
    end
  end

  private

  def obtener_json_podcast
    { 'podcast': @contenido.id,
      'detalles': {
        'nombre': @contenido.nombre,
        'autor': @contenido.nombre_autor,
        'genero': @contenido.genero,
        'episodios': obtener_json_episodios(@contenido.episodios)
      } }.to_json
  end

  def obtener_json_episodios(episodios)
    detalles_episodios = {}
    episodios.each do |episodio|
      detalles_episodios[episodio.numero_episodio.to_s] = {
        'nombre': episodio.nombre,
        'duracion': episodio.duracion
      }
    end
    detalles_episodios
  end

  def obtener_json_cancion
    { 'cancion': @contenido.id,
      'detalles': {
        'nombre': @contenido.nombre,
        'autor': @contenido.nombre_autor,
        'anio': @contenido.anio,
        'duracion': @contenido.duracion,
        'genero': @contenido.genero
      } }.to_json
  end
end
