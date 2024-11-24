require 'spec_helper'
require_relative '../../dominio/cancion'
require_relative '../../dominio/informacion_contenido'

describe Cancion do
  it 'requiere informacion de la cancion' do
    autor = instance_double('Autor', nombre: 'autor')
    info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
    cancion = described_class.new(info_cancion)
    expect(cancion).not_to be_nil
  end

  it 'es_una_cancion? deberia devolver true' do
    autor = instance_double('Autor', nombre: 'autor')
    info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
    cancion = described_class.new(info_cancion)
    expect(cancion.es_una_cancion?).to eq true
  end

  describe 'nombre_autor' do
    it 'deberia devolver el nombre del autor de la cancion' do
      autor = instance_double('Autor', nombre: 'autor')
      info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
      cancion = described_class.new(info_cancion)
      expect(cancion.nombre_autor).to eq 'autor'
    end
  end

  describe 'es_el_mismo?' do
    it 'deberia devolver true si es la misma cancion' do
      autor = instance_double('Autor', nombre: 'autor')
      info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
      cancion = described_class.new(info_cancion, 1)
      expect(cancion.es_el_mismo?(cancion)).to be true
    end

    it 'deberia devolver false si no es la misma cancion' do
      autor = instance_double('Autor', nombre: 'autor')
      info_cancion = InformacionContenido.new('nombre', autor, 2021, 180, 'rock')
      cancion = described_class.new(info_cancion, 1)
      cancion2 = described_class.new(info_cancion, 2)
      expect(cancion.es_el_mismo?(cancion2)).to be false
    end
  end
end
