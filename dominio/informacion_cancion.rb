class InformacionCancion
  attr_reader :nombre, :autor, :anio, :duracion, :genero

  def initialize(nombre, autor, anio, duracion, genero)
    @nombre = nombre
    @autor = autor
    @anio = anio
    @duracion = duracion
    @genero = genero
  end
end
