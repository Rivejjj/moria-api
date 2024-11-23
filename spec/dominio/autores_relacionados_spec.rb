require 'spec_helper'
require_relative '../../dominio/autores_relacionados'

describe AutoresRelacionados do
  it 'deberia devolver el autor a relacionar' do
    autor = instance_double('Autor')
    relacionados = [instance_double('Autor1'), instance_double('Autor2'), instance_double('Autor3')]
    autores_relacionados = described_class.new(autor, relacionados)
    expect(autores_relacionados.autor).to eq(autor)
  end

  it 'deberia devolver los autores relacionados' do
    autor = instance_double('Autor')
    relacionados = [instance_double('Autor1'), instance_double('Autor2'), instance_double('Autor3')]
    autores_relacionados = described_class.new(autor, relacionados)
    expect(autores_relacionados.relacionados).to eq(relacionados)
  end
end
