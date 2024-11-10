require 'integration_helper'
require_relative '../../dominio/cancion'
require_relative '../../dominio/informacion_cancion'
require_relative '../../persistencia/repositorio_contenido'

describe RepositorioContenido do
  it 'deberia guardar y asignar id a una cancion' do
    info_cancion = InformacionCancion.new('nombre', 'autor', 2021, 180, 'rock')
    cancion = Cancion.new(info_cancion)
    described_class.new.save(cancion)
    expect(cancion.id).not_to be_nil
  end
end
