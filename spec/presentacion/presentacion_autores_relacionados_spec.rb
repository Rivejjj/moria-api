require 'spec_helper'
require_relative '../../presentacion/presentacion_autores_relacionados'

describe PresentacionAutoresRelacionados do
  json_esperado = {
    'relacionados': [
      'Fito Paez',
      'Lady Gaga',
      'Pharrell Williams'
    ]
  }.to_json

  describe 'obtener_json' do
    it 'deberia obtener el json de los primeros tres autores relacionados' do
      autor1 = instance_double('Autor', nombre: 'Fito Paez')
      autor2 = instance_double('Autor', nombre: 'Lady Gaga')
      autor3 = instance_double('Autor', nombre: 'Pharrell Williams')
      autor4 = instance_double('Autor', nombre: 'Michael Jackson')
      autores_relacionados = instance_double('AutoresRelacionados', relacionados: [autor1, autor2, autor3, autor4])
      presentacion_autores_relacionados = described_class.new(autores_relacionados)
      expect(presentacion_autores_relacionados.obtener_json).to eq json_esperado
    end
  end
end
