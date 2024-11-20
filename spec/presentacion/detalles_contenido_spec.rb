require 'spec_helper'
require_relative '../../presentacion/detalles_contenido'

describe DetallesContenido do
  describe 'obtener_json' do
    cancion_json_esperada = {
      'cancion': 1,
      'detalles': {
        'nombre': 'Beat it',
        'autor': 'Michael Jackson',
        'anio': 1983,
        'duracion': 378,
        'genero': 'Pop'
      }
    }.to_json

    podcast_json_esperado = {
      'podcast': 1,
      'detalles': {
        'nombre': 'JRE',
        'autor': 'Michael Jackson',
        'genero': 'Cultura',
        'episodios': {
          '1': { 'nombre': 'Primer episodio', 'duracion': 916 },
          '2': { 'nombre': 'Segundo episodio', 'duracion': 4368 }
        }
      }
    }.to_json

    it 'deberia obtener el json de los detalles de una cancion' do
      cancion = instance_double(Cancion, nombre: 'Beat it', autor: 'Michael Jackson', anio: 1983, duracion: 378, genero: 'Pop', id: 1)
      allow(cancion).to receive(:is_a?).with(Cancion).and_return(true)
      detalles_contenido = described_class.new(cancion)

      expect(detalles_contenido.obtener_json).to eq cancion_json_esperada
    end

    it 'deberia obtener el json de los detalles de un podcast' do
      episodio1 = instance_double(EpisodioPodcast, nombre: 'Primer episodio', duracion: 916, numero_episodio: 1)
      episodio2 = instance_double(EpisodioPodcast, nombre: 'Segundo episodio', duracion: 4368, numero_episodio: 2)
      podcast = instance_double(Podcast, nombre: 'JRE', autor: 'Michael Jackson', genero: 'Cultura', episodios: [episodio1, episodio2], id: 1)

      allow(podcast).to receive(:is_a?).with(Podcast).and_return(true)
      allow(podcast).to receive(:is_a?).with(Cancion).and_return(false)

      detalles_contenido = described_class.new(podcast)
      expect(detalles_contenido.obtener_json).to eq podcast_json_esperado
    end
  end
end
