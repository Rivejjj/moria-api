require 'spec_helper'
require_relative '../../dominio/podcast'
require_relative '../../dominio/informacion_contenido'

describe Podcast do
  it 'requiere informacion del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast).not_to be_nil
  end

  it 'se puede obtener el nombre del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast.nombre).to eq(info_podcast.nombre)
  end

  it 'se puede obtener el autor del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast.autor).to eq(info_podcast.autor)
  end

  it 'se puede obtener el anio del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast.anio).to eq(info_podcast.anio)
  end

  it 'se puede obtener la duracion del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast.duracion).to eq(info_podcast.duracion)
  end

  it 'se puede obtener el genero del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast.genero).to eq(info_podcast.genero)
  end

  it 'se puede obtener la fecha de creacion del podcast' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast, 1, Date.new(2021, 1, 1))
    expect(podcast.created_on).to eq(Date.new(2021, 1, 1))
  end

  it 'es_una_cancion? deberia devolver false' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    expect(podcast.es_una_cancion?).to eq false
  end

  it 'deberia poder agregar un episodio' do
    info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
    podcast = described_class.new(info_podcast)
    episodio = instance_double('EpisodioPodcast')
    podcast.agregar_episodio(episodio)
    expect(podcast.episodios).to include(episodio)
  end

  describe 'es_el_mismo?' do
    it 'deberia devolver true si es el mismo podcast' do
      info_podcast = InformacionContenido.new('nombre', 'autor', 2021, 180, 'rock')
      podcast = described_class.new(info_podcast)
      expect(podcast.es_el_mismo?(podcast)).to be true
    end
  end
end
