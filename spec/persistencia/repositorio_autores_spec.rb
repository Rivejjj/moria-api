require 'integration_helper'
require_relative '../../dominio/autor'
require_relative '../../persistencia/repositorio_autores'

describe RepositorioAutores do
  before(:each) do
    described_class.new.delete_all
  end

  it 'deberia guardar y asignar id a un autor' do
    autor = Autor.new('Michael Jackson', '3fMbdgg4jU18AjLCKBhRSm')
    described_class.new.save(autor)
    expect(autor.id).not_to be_nil
  end

  it 'deberia encontrar el primer autor' do
    autor = Autor.new('Michael Jackson', '3fMbdgg4jU18AjLCKBhRSm')
    repo_autores = described_class.new
    repo_autores.save(autor)
    autor_encontrado = repo_autores.first
    expect(autor_encontrado.nombre).to eq(autor.nombre)
    expect(autor_encontrado.id_externo).to eq(autor.id_externo)
  end

  describe 'get' do
    it 'deberia encontrar un autor por su id' do
      autor = Autor.new('Michael Jackson', '3fMbdgg4jU18AjLCKBhRSm')
      repo_autores = described_class.new
      repo_autores.save(autor)
      autor_encontrado = repo_autores.get(autor.id)
      expect(autor_encontrado.id).to eq autor.id
    end

    it 'deberia levantar un error si no se encuentra al autor' do
      expect { described_class.new.get(1) }.to raise_error(AutorNoEncontradoError)
    end
  end
end
