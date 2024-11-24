require 'spec_helper'
require_relative '../../dominio/recomendador_de_contenido'

describe RecomendadorDeContenido do
  it 'deberia recomendar a un usuario los ultimos 5 contenidos agregados a su playlist' do
    recomendador = described_class.new(instance_double('RepositorioContenido'))
    usuario = instance_double('Usuario', playlist: %w[cancion1 cancion2 cancion3 cancion4 cancion5 cancion6])
    expect(recomendador.recomendar_contenido(usuario)).to eq(%w[cancion6 cancion5 cancion4 cancion3 cancion2])
  end

  it 'deberia recomendar una cancion del genero mas gustado' do
    cancion_rock1 = crear_mock_contenido
    cancion_rock2 = crear_mock_contenido

    repo_contenido = instance_double('RepositorioContenido', get_canciones_de_genero: [cancion_rock1, cancion_rock2])

    me_gustas = MeGustasUsuario.new(instance_double('Usuario'), [cancion_rock1])

    recomendador = described_class.new(repo_contenido)
    cancion_recomendada = recomendador.recomendar_cancion_de_genero_mas_gustado(me_gustas)
    expect(cancion_recomendada.genero).to eq('rock')
    expect(cancion_recomendada).to eq(cancion_rock2)
  end

  it 'deberia recomendar un podcast del genero mas gustado' do
    podcast_rock1 = crear_mock_contenido
    podcast_rock2 = crear_mock_contenido

    repo_contenido = instance_double('RepositorioContenido', get_podcasts_de_genero: [podcast_rock1, podcast_rock2])

    me_gustas = MeGustasUsuario.new(instance_double('Usuario'), [podcast_rock1])

    recomendador = described_class.new(repo_contenido)
    podcast_recomendada = recomendador.recomendar_podcast_de_genero_mas_gustado(me_gustas)
    expect(podcast_recomendada.genero).to eq('rock')
    expect(podcast_recomendada).to eq(podcast_rock2)
  end
end

def crear_mock_contenido
  contenido_rock = instance_double('Contenido', genero: 'rock')
  allow(contenido_rock).to receive(:es_el_mismo?) { |contenido| contenido == contenido_rock }
  contenido_rock
end
