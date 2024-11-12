require 'spec_helper'
require_relative '../../dominio/recomendador_de_contenido'

describe RecomendadorDeContenido do
  it 'deberia recomendar a un usuario los ultimos 5 contenidos agregados a su playlist' do
    recomendador = described_class.new
    usuario = instance_double('Usuario', playlist: %w[cancion1 cancion2 cancion3 cancion4 cancion5 cancion6])
    expect(recomendador.recomendar_contenido(usuario)).to eq(%w[cancion6 cancion5 cancion4 cancion3 cancion2])
  end
end
