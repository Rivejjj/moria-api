class Reproducciones
  attr_reader :reproducido, :reproducciones

  def initialize(reproducido)
    @reproducido = reproducido
    @reproducciones = []
  end

  def contiene_reproduccion_de?(_usuario)
    raise 'Subclass must implement'
  end

  def agregar_reproduccion(reproduccion)
    @reproducciones << reproduccion
  end

  def reproducciones_de_la_semana(proveedor_de_fecha)
    reproducciones_semana = @reproducciones.select { |reproduccion| reproduccion.fue_reproducido_hace_menos_de_una_semana?(proveedor_de_fecha) }

    nuevo = self.class.new(@cancion)
    reproducciones_semana.each { |reproduccion| nuevo.agregar_reproduccion(reproduccion) }
    nuevo
  end
end
