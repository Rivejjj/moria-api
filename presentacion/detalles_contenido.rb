class DetallesContenido
  def initialize(contenido)
    @contenido = contenido
  end

  def obtener_json
    { 'cancion': @contenido.id,
      'detalles': {
        'nombre': @contenido.nombre,
        'autor': @contenido.autor,
        'anio': @contenido.anio,
        'duracion': @contenido.duracion,
        'genero': @contenido.genero
      } }.to_json
  end
end
