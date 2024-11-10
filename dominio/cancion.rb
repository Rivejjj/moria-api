class Cancion
  attr_reader :nombre, :autor, :anio, :duracion, :genero, :updated_on, :created_on
  attr_accessor :id

  def initialize(nombre, autor, anio, duracion, genero, id = nil) # rubocop:disable Metrics/ParameterLists
    @nombre = nombre
    @autor = autor
    @anio = anio
    @duracion = duracion
    @genero = genero
    @id = id
  end
end
