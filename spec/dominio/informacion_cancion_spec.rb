require 'spec_helper'
require_relative '../../dominio/informacion_cancion'

describe InformacionCancion do
  it 'requiere nombre, autor, anio, duracion, genero' do
    informacion_cancion = described_class.new('nombre', 'autor', 2021, 180, 'rock')
    expect(informacion_cancion).not_to be_nil
  end
end
