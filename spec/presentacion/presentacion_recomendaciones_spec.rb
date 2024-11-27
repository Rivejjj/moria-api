require 'spec_helper'
require_relative '../../presentacion/presentacion_recomendaciones'

describe PresentacionRecomendaciones do
  json_esperado = {
    recomendacion: [
      { 'id_contenido': 1, 'nombre': 'cancion_de_juan' },
      { 'id_contenido': 3, 'nombre': 'podcast_de_alan' }
    ]
  }.to_json

  describe 'obtener_json' do
    it 'deberia obtener el json de la recomendacion' do
      contenido1 = instance_double(Contenido, nombre: 'cancion_de_juan', id: 1)
      contenido2 = instance_double(Contenido, nombre: 'podcast_de_alan', id: 3)
      recomendaciones = [contenido1, contenido2]
      presentacion_recomendaciones = described_class.new(recomendaciones)
      expect(presentacion_recomendaciones.obtener_json).to eq json_esperado
    end
  end
end
