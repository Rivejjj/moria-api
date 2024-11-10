require 'spec_helper'
require_relative '../../dominio/cancion'
require_relative '../../dominio/informacion_cancion'

describe Cancion do
  it 'requiere informacion de la cancion' do
    info_cancion = InformacionCancion.new('nombre', 'autor', 2021, 180, 'rock')
    cancion = described_class.new(info_cancion)
    expect(cancion).not_to be_nil
  end
end
