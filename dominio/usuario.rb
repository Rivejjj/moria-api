class Usuario
  attr_reader :nombre, :email, :id_plataforma, :updated_on, :created_on
  def initialize(nombre, email, id_plataforma)
    @nombre = nombre
    @email = email
    @id_plataforma = id_plataforma
  end
end
