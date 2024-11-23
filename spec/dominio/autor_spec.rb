require 'spec_helper'
require_relative '../../dominio/autor'

describe Autor do
  nombre = 'Michael Jackson'
  id_externo = '3fMbdgg4jU18AjLCKBhRSm'

  it 'se puede obtener el nombre del autor' do
    autor = described_class.new(nombre, id_externo)
    expect(autor.nombre).to eq(nombre)
  end

  it 'se puede obtener el id externo del autor' do
    autor = described_class.new(nombre, id_externo)
    expect(autor.id_externo).to eq(id_externo)
  end
end
