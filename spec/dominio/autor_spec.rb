require_relative '../../dominio/autor'

describe Autor do
  it 'se puede obtener el nombre del autor' do
    nombre = 'Michael Jackson'
    autor = described_class.new(nombre)
    expect(autor.nombre).to eq(nombre)
  end
end
