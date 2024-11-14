require 'spec_helper'
require_relative '../../dominio/informacion_contenido'

describe InformacionContenido do
  it 'requiere nombre, autor, anio, duracion, genero' do
    informacion_contenido = described_class.new('nombre', 'autor', 2021, 180, 'rock')
    expect(informacion_contenido).not_to be_nil
  end
end
