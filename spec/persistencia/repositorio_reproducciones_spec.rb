require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../dominio/podcast'
require_relative '../../dominio/episodio_podcast'
require_relative '../../dominio/informacion_contenido'
Dir[File.join(__dir__, '../../persistencia', '*.rb')].each { |file| require file }

describe RepositorioReproducciones do
  it 'deberia recuperar las reproducciones de un episodio' do
    usuario = crear_y_guardar_usuario
    episodio_podcast = crear_podcast_con_episodio
    reproducciones = ReproduccionesEpisodioPodcast.new(episodio_podcast)
    reproducciones.agregar_reproduccion_de(usuario)

    described_class.new.save_reproducciones_episodio_podcast(reproducciones)

    reproducciones_conseguidas = described_class.new.get_reproducciones_episodio_podcast(episodio_podcast.id)
    expect(reproducciones_conseguidas.usuarios.any? { |un_usuario| un_usuario.es_el_mismo_usuario_que?(usuario) }).to be(true)
    expect(reproducciones_conseguidas.episodio_podcast.id).to eq episodio_podcast.id
  end
end

def crear_podcast_con_episodio
  info_contenido = InformacionContenido.new('nombre', 'autor', 2021, 180, 'genero')
  podcast = Podcast.new(info_contenido, 1)
  episodio_podcast = EpisodioPodcast.new(1, 'nombre', 180)
  podcast.agregar_episodio(episodio_podcast)
  RepositorioContenido.new.save(podcast)
  episodio_podcast
end

def crear_y_guardar_usuario
  usuario = Usuario.new('juan', 'juan@juan', '123456789')
  RepositorioUsuarios.new.save(usuario)
  usuario
end
