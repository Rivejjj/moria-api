class Reproducciones
  attr_reader :reproducido

  def initialize(reproducido)
    @reproducido = reproducido
  end

  def agregar_reproduccion_de(_usuario)
    raise 'Subclass must implement'
  end

  def contiene_reproduccion_de?(_usuario)
    raise 'Subclass must implement'
  end
end
