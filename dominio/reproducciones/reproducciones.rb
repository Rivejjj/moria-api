class Reproducciones
  attr_reader :reproducido, :reproducciones

  def initialize(reproducido)
    @reproducido = reproducido
    @reproducciones = []
  end

  def contiene_reproduccion_de?(_usuario)
    raise 'Subclass must implement'
  end
end
