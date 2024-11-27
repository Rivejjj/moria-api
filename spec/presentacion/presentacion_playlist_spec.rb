require 'spec_helper'
require_relative '../../presentacion/presentacion_playlist'

describe PresentacionPlaylist do
  json_esperado = {
    playlist: [
      { 'id_contenido': 1, 'nombre': 'cancion_de_juan' },
      { 'id_contenido': 3, 'nombre': 'podcast_de_alan' }
    ]
  }.to_json

  describe 'obtener_json' do
    it 'deberia obtener el json de la playlist' do
      contenido1 = instance_double(Contenido, nombre: 'cancion_de_juan', id: 1)
      contenido2 = instance_double(Contenido, nombre: 'podcast_de_alan', id: 3)
      playlist = [contenido1, contenido2]
      presentacion_playlist = described_class.new(playlist)
      expect(presentacion_playlist.obtener_json).to eq json_esperado
    end
  end
end
