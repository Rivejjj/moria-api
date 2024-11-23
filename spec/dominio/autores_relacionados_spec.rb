require 'spec_helper'
require_relative '../../dominio/autores_relacionados'

describe AutoresRelacionados do
  it 'deberia devolver el autor a relacionar' do
    autor = instance_double('Autor')
    autores_relacionados = described_class.new(autor)
    expect(autores_relacionados.autor).to eq(autor)
  end
end
