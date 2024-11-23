class AutoresRelacionados
  attr_reader :autor, :relacionados

  def initialize(autor, relacionados)
    @autor = autor
    @relacionados = relacionados
  end
end
