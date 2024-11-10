require 'spec_helper'
require_relative '../../dominio/cancion'

describe Cancion do
  it 'requiere nombre, autor, anio, duracion, genero' do
    cancion = described_class.new('nombre', 'autor', 2021, 180, 'rock')
    expect(cancion).not_to be_nil
  end
end
