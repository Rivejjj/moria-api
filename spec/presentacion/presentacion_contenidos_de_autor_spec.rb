require 'spec_helper'
require_relative '../../presentacion/presentacion_contenidos_de_autor'

describe PresentacionContenidosDeAutor do
  json_esperado = {
    'contenidos': [
      { 'id_contenido': 3, 'nombre': 'Beat It' },
      { 'id_contenido': 7, 'nombre': 'Thriller' }
    ]
  }.to_json

  describe 'obtener_json' do
    it 'deberia obtener el json de los contenidos de un autor' do
      contenidos_de_autor = [instance_double(Contenido, id: 3, nombre: 'Beat It'), instance_double(Contenido, id: 7, nombre: 'Thriller')]
      presentacion_contenidos_de_autor = described_class.new(contenidos_de_autor)
      expect(presentacion_contenidos_de_autor.obtener_json).to eq json_esperado
    end
  end
end
