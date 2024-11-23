require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../dominio/podcast'
require_relative '../../dominio/episodio_podcast'
require_relative '../../dominio/informacion_contenido'
Dir[File.join(__dir__, '../../persistencia', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, '../../dominio/reproducciones', '*.rb')].each { |file| require file }

describe RepositorioReproducciones do
  before(:each) do
    RepositorioContenido.new.delete_all
    RepositorioEpisodiosPodcast.new.delete_all
    described_class.new.delete_all
  end

  it 'deberia recuperar las reproducciones de un episodio' do
    usuario = crear_y_guardar_usuario
    episodio_podcast = crear_podcast_con_episodio
    reproducciones = ReproduccionesEpisodioPodcast.new(episodio_podcast)
    reproducciones.agregar_reproduccion_de(usuario)

    described_class.new.save_reproducciones_episodio_podcast(reproducciones)

    reproducciones_conseguidas = described_class.new.get_reproducciones_episodio_podcast(episodio_podcast.id)
    expect(reproducciones_conseguidas.reproducciones.any? { |reproduccion| reproduccion.reproducido_por?(usuario) }).to be(true)
    expect(reproducciones_conseguidas.reproducido.id).to eq episodio_podcast.id
  end

  it 'deberia guardar todas las reproducciones de un episodio de un usuario' do
    usuario = crear_y_guardar_usuario
    episodio_podcast = crear_podcast_con_episodio
    reproducciones = ReproduccionesEpisodioPodcast.new(episodio_podcast)
    reproducciones.agregar_reproduccion_de(usuario)
    reproducciones.agregar_reproduccion_de(usuario)

    described_class.new.save_reproducciones_episodio_podcast(reproducciones)

    reproducciones_conseguidas = described_class.new.get_reproducciones_episodio_podcast(episodio_podcast.id)
    expect(reproducciones_conseguidas.reproducciones.size).to eq 2
  end

  it 'deberia obtener todas las reproducciones de episodios del podcast' do
    usuario = crear_y_guardar_usuario
    podcast_id = 1
    crear_podcast_con_episodios_y_reproducir(2, usuario, podcast_id)
    reproducciones_podcast = described_class.new.get_reproducciones_podcast(podcast_id)

    expect(reproducciones_podcast.reproducciones.size).to eq 2
    expect(reproducciones_podcast.reproducido.id).to eq podcast_id
  end

  it 'deberia recuperar las reproducciones de una cancion' do
    usuario = crear_y_guardar_usuario
    cancion = crear_y_guardar_cancion

    reproducciones_cancion = ReproduccionesCancion.new(cancion)
    reproducciones_cancion.agregar_reproduccion_de(usuario)

    described_class.new.save_reproducciones_cancion(reproducciones_cancion)

    reproducciones_conseguidas = described_class.new.get_reproducciones_cancion(cancion.id)
    expect(reproducciones_conseguidas.reproducciones.any? { |reproduccion| reproduccion.reproducido_por?(usuario) }).to be(true)
    expect(reproducciones_conseguidas.reproducido.id).to eq cancion.id
  end

  it 'deberia recuperar las reproducciones de una cancion con su fecha' do
    usuario = crear_y_guardar_usuario
    cancion = crear_y_guardar_cancion

    reproducciones_cancion = ReproduccionesCancion.new(cancion)
    reproducciones_cancion.agregar_reproduccion_de(usuario)

    described_class.new.save_reproducciones_cancion(reproducciones_cancion)

    reproducciones_conseguidas = described_class.new.get_reproducciones_cancion(cancion.id)
    expect(reproducciones_conseguidas.reproducciones.any? { |reproduccion| reproduccion.fecha.nil? }).to be false
  end

  it 'deberia recuperar las reproducciones de un episodio con su fecha' do
    usuario = crear_y_guardar_usuario
    episodio_podcast = crear_podcast_con_episodio
    reproducciones = ReproduccionesEpisodioPodcast.new(episodio_podcast)
    reproducciones.agregar_reproduccion_de(usuario)

    described_class.new.save_reproducciones_episodio_podcast(reproducciones)

    reproducciones_conseguidas = described_class.new.get_reproducciones_episodio_podcast(episodio_podcast.id)
    expect(reproducciones_conseguidas.reproducciones.any? { |reproduccion| reproduccion.fecha.nil? }).to be false
  end

  it 'deberia guardar todas las reproducciones de una cancion de un usuario' do
    usuario = crear_y_guardar_usuario
    cancion = crear_y_guardar_cancion
    reproducciones_cancion = ReproduccionesCancion.new(cancion)
    reproducciones_cancion.agregar_reproduccion_de(usuario)
    reproducciones_cancion.agregar_reproduccion_de(usuario)

    described_class.new.save_reproducciones_cancion(reproducciones_cancion)

    reproducciones_conseguidas = described_class.new.get_reproducciones_cancion(cancion.id)

    expect(reproducciones_conseguidas.reproducciones.size).to eq 2
  end
end

def crear_podcast_con_episodio(podcast_id = 1, numero_episodio = 1)
  autor = Autor.new('autor', '12345678')
  RepositorioAutores.new.save(autor)
  info_contenido = InformacionContenido.new('nombre', autor, 2021, 180, 'genero')
  podcast = Podcast.new(info_contenido, podcast_id)
  episodio_podcast = EpisodioPodcast.new(numero_episodio, 'nombre', 180)
  podcast.agregar_episodio(episodio_podcast)
  RepositorioContenido.new.save(podcast)
  episodio_podcast
end

def crear_podcast_con_episodios_y_reproducir(cantidad_episodios, usuario, podcast_id = 1)
  (1..cantidad_episodios).each do |numero_episodio|
    reproducciones_episodio = ReproduccionesEpisodioPodcast.new(crear_podcast_con_episodio(podcast_id, numero_episodio))
    reproducciones_episodio.agregar_reproduccion_de(usuario)
    RepositorioReproducciones.new.save_reproducciones_episodio_podcast(reproducciones_episodio)
  end
end

def crear_y_guardar_usuario(id = 1)
  usuario = Usuario.new('juan', 'juan@juan', '123456789', id)
  RepositorioUsuarios.new.save(usuario)
  usuario
end

def crear_y_guardar_cancion(id = 1)
  autor = Autor.new('autor', '12345678')
  RepositorioAutores.new.save(autor)
  info_contenido = InformacionContenido.new('nombre', autor, 2021, 180, 'genero')
  cancion = Cancion.new(info_contenido, id)
  RepositorioContenido.new.save(cancion)
  cancion
end
