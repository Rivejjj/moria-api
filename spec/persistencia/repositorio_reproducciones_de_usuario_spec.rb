require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../dominio/podcast'
require_relative '../../dominio/episodio_podcast'
require_relative '../../dominio/informacion_contenido'
Dir[File.join(__dir__, '../../persistencia', '*.rb')].each { |file| require file }

describe RepositorioReproduccionesDeUsuario do
  it 'deberia recuperar varios episodios reproducidos de un usuario' do
    juan = Usuario.new('juan', 'juan@test.com', '1')
    episodio1 = insertar_episodio_y_reproducir(juan, 1)
    episodio2 = insertar_episodio_y_reproducir(juan, 2)

    reproducciones = described_class.new.load(juan)
    expect(reproducciones.map(&:id)).to include(episodio1.id, episodio2.id)
    expect(reproducciones.length).to eq(2)
  end
end

def insertar_episodio_y_reproducir(usuario, numero_episodio)
  episodio_podcast = insertar_episodio_podcast(numero_episodio)
  usuario.agregar_reproduccion(episodio_podcast)
  RepositorioUsuarios.new.save(usuario)
  episodio_podcast
end
