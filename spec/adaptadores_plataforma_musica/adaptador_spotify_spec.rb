require 'spec_helper'
require_relative '../../adaptadores_plataforma_musica/adaptador_spotify'

describe AdaptadorSpotify do
  describe 'obtener_token' do
    it 'deberia devolver un token' do
      token = described_class.new.obtener_token
      expect(token).to be_a(String)
    end
  end
end
