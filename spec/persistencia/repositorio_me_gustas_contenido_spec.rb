require 'integration_helper'
require_relative '../../dominio/usuario'
require_relative '../../dominio/podcast'
require_relative '../../dominio/episodio_podcast'
require_relative '../../dominio/informacion_contenido'
Dir[File.join(__dir__, '../../persistencia', '*.rb')].each { |file| require file }

describe RepositorioMeGustasContenido do
  it 'deberia recuperar los me gustas de un podcast' do
    usuario = crear_y_guardar_usuario
    reproducciones_podcast = crear_reproducciones_podcast(usuario, 1)

    me_gustas_contenido = MeGustasContenido.new(reproducciones_podcast)
    me_gustas_contenido.agregar_me_gusta_de(usuario)

    described_class.new.save(me_gustas_contenido)

    me_gustas_conseguido = described_class.new.get(1)
    expect(me_gustas_conseguido.reproducciones_contenido.reproducido.id).to eq 1
    expect(me_gustas_conseguido.usuarios.any? { |un_usuario| un_usuario.es_el_mismo_usuario_que?(usuario) }).to be(true)
  end
end

def crear_reproducciones_podcast(usuario, id_podcast)
  crear_podcast_con_episodios_y_reproducir(2, usuario, id_podcast)
  RepositorioReproducciones.new.get_reproducciones_podcast(id_podcast)
end
