require 'spec_helper'
require_relative '../../adaptadores_plataforma_musica/adaptador_spotify'

describe AdaptadorSpotify do
  describe 'obtener_token' do
    it 'deberia devolver un token' do
      token = described_class.new.obtener_token
      expect(token).to be_a(String)
      expect(token).not_to be_empty
    end
  end

  describe 'obtener_autores_relacionados_a' do
    it 'deberia devolver los autores relacionados a un autor' do
      autor = instance_double('Autor', id_externo: '3fMbdgg4jU18AjLCKBhRSm')
      autores_relacionados = described_class.new.obtener_autores_relacionados_a(autor)
      expect(autores_relacionados.autor).to eq(autor)
      expect(autores_relacionados.relacionados).to all(be_a(Autor))
    end
  end
end
