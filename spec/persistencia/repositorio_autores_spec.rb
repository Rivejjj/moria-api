require 'integration_helper'
require_relative '../../dominio/autor'
require_relative '../../persistencia/repositorio_autores'

describe RepositorioAutores do
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
end
