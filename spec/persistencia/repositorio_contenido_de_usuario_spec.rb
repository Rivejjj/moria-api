require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../dominio/podcast'
require_relative '../../dominio/episodio_podcast'
require_relative '../../dominio/informacion_contenido'
Dir[File.join(__dir__, '../../persistencia', '*.rb')].each { |file| require file }

describe RepositorioContenidoDeUsuario do
  it 'deberia recuperar episodios reproducidos de un usuario' do
    usuario = Usuario.new('juan', 'uan@juan.com', '1')
    episodio_podcast = insertar_episodio_podcast

    usuario.agregar_reproduccion(episodio_podcast)
    RepositorioUsuarios.new.save(usuario)
    episodio_obtenido = RepositorioUsuarios.new.find(usuario.id).reproducciones[0]

    expect(episodio_obtenido.id).to eq(episodio_podcast.id)
    expect(episodio_obtenido.es_una_cancion?).to be false
  end
end

def insertar_episodio_podcast(numero_episodio = 1)
  info = InformacionContenido.new('cancion', 'autor', 2020, 180, 'rock')
  podcast = Podcast.new(info)
  episodio_podcast = EpisodioPodcast.new(numero_episodio, 'episodio', 180)

  podcast.agregar_episodio(episodio_podcast)
  RepositorioContenido.new.save(podcast)

  episodio_podcast
end
