require 'integration_helper'
require_relative '../../dominio/autor'
require_relative '../../persistencia/repositorio_autores'

describe RepositorioAutores do
  it 'deberia guardar y asignar id a un autor' do
    autor = Autor.new('Michael Jackson', '3fMbdgg4jU18AjLCKBhRSm')
    described_class.new.save(autor)
    expect(autor.id).not_to be_nil
  end
end
