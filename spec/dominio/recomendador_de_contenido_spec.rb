require 'spec_helper'
require_relative '../../dominio/recomendador_de_contenido'

describe RecomendadorDeContenido do
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

  it 'deberia recomendar un podcast y una cancion del genero mas gustado' do
    podcasts = [crear_mock_contenido, crear_mock_contenido]
    canciones = [crear_mock_contenido, crear_mock_contenido]

    repo_contenido = instance_double('RepositorioContenido', get_podcasts_de_genero: [podcasts[0], podcasts[1]], get_canciones_de_genero: [canciones[0], canciones[1]])

    me_gustas = MeGustasUsuario.new(instance_double('Usuario'), [podcasts[0], canciones[0]])

    recomendador = described_class.new(repo_contenido)
    recomendacion = recomendador.recomendar_contenido(me_gustas)
    expect(recomendacion).to eq([canciones[1], podcasts[1]])
  end

  xit 'si no encuentra podcast o cancion del genero mas gustado, devuelve de las ultimas agregadas que no haya gustado el usuario' do
    podcast = crear_mock_contenido
    cancion = crear_mock_contenido
    repo_contenido = instance_double('RepositorioContenido', get_podcasts_de_genero: [], get_canciones_de_genero: [], ultimos_contenidos: [podcast, cancion])
    me_gustas = MeGustasUsuario.new(instance_double('Usuario'), [])

    recomendador = described_class.new(repo_contenido)
    recomendacion = recomendador.recomendar_contenido(me_gustas)
    expect(recomendacion).to eq([cancion, podcast])
  end

end

def crear_mock_contenido
  contenido_rock = instance_double('Contenido', genero: 'rock')
  allow(contenido_rock).to receive(:es_el_mismo?) { |contenido| contenido == contenido_rock }
  contenido_rock
end
