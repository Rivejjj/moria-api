require 'spec_helper'
require_relative '../../presentacion/presentacion_top_semanal'

describe PresentacionTopSemanal do
  json_esperado = {
    top_semanal: [
      { 'id_contenido': 1, 'nombre': 'cancion_de_juan' },
      { 'id_contenido': 2, 'nombre': 'cancion_de_ivan' },
      { 'id_contenido': 3, 'nombre': 'podcast_de_alan' }
    ]
  }.to_json

  describe 'obtener_json' do
    it 'deberia obtener el json del top semanal' do
      contenido1 = instance_double(Contenido, nombre: 'cancion_de_juan', id: 1)
      contenido2 = instance_double(Contenido, nombre: 'cancion_de_ivan', id: 2)
      contenido3 = instance_double(Contenido, nombre: 'podcast_de_alan', id: 3)
      top_semanal = [contenido1, contenido2, contenido3]
      presentacion_top_semanal = described_class.new(top_semanal)
      expect(presentacion_top_semanal.obtener_json).to eq json_esperado
    end
  end
end
