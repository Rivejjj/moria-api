class Autor
  attr_reader :nombre, :id_externo

  def initialize(nombre, id_externo)
    @nombre = nombre
    @id_externo = id_externo
  end
end
