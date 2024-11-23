require 'spec_helper'
require_relative '../../dominio/top_semanal'

describe TopSemanal do
  it 'deberia devolver los 3 contenidos mas reproducidos' do
    reproducciones = [crear_reproducciones_de_cancion(1, 3),
                      crear_reproducciones_de_podcast(2, 4),
                      crear_reproducciones_de_podcast(3, 1),
                      crear_reproducciones_de_cancion(4, 5)]
    repositorio_reproducciones = instance_double('RepositorioReproducciones', all: reproducciones)
    proveedor_fecha = instance_double('ProveedorFecha', en_la_ultima_semana?: true)
    top_semanal = described_class.new(repositorio_reproducciones, proveedor_fecha)
    expect(top_semanal.obtener_contenidos.map(&:id)).to eq [4, 2, 1]
  end
end

def crear_reproducciones_de_cancion(id_contenido, cantidad_reproducciones)
  cancion = instance_double('cancion', id: id_contenido)
  reproducciones = ReproduccionesCancion.new(cancion)
  (0..cantidad_reproducciones - 1).each do
    reproduccion = Reproduccion.new(instance_double('Usuario'))
    reproducciones.agregar_reproduccion(reproduccion)
  end
  reproducciones
end

def crear_reproducciones_de_podcast(id_contenido, cantidad_reproducciones)
  podcast = instance_double('Podcast', id: id_contenido)
  episodio = instance_double('EpisodioPodcast')
  reproducciones_episodio = ReproduccionesEpisodioPodcast.new(episodio)
  (0..cantidad_reproducciones - 1).each do
    reproduccion = Reproduccion.new(instance_double('Usuario'))
    reproducciones_episodio.agregar_reproduccion(reproduccion)
  end
  ReproduccionesPodcast.new(podcast, [reproducciones_episodio])
end
