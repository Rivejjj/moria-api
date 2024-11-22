class Autor
  attr_reader :nombre, :id_externo, :created_on, :updated_on
  attr_accessor :id

  def initialize(nombre, id_externo, id = nil)
    @nombre = nombre
    @id_externo = id_externo
    @id = id
  end
end
