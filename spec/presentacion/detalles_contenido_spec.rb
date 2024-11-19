require 'spec_helper'
require_relative '../../presentacion/detalles_contenido'

describe DetallesContenido do
  describe 'obtener_json' do
    cancion_json_esperada = { 'cancion': {
      'nombre': 'Beat it',
      'autor': 'Michael Jackson',
      'anio': 1983,
      'duracion': 378,
      'genero': 'Pop'
    } }.to_json

    it 'deberia obtener el json de los detalles de una cancion' do
      cancion = instance_double(Cancion, nombre: 'Beat it', autor: 'Michael Jackson', anio: 1983, duracion: 378, genero: 'Pop')
      detalles_contenido = described_class.new(cancion)

      expect(detalles_contenido.obtener_json).to eq cancion_json_esperada
    end
  end
end
