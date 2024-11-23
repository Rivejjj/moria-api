require 'spec_helper'
require_relative '../../proveedor_de_fecha/proveedor_de_fecha_date'
describe ProveedorDeFechaDate do
  describe 'en_la_ultima_semana?' do
    it 'deberia devolver true si la fecha recibida esta dentro de la ultima semana' do
      expect(described_class.new.en_la_ultima_semana?(Date.today)).to eq true
    end

    it 'deberia devolver false si la fecha recibida esta fuera de la ultima semana' do
      expect(described_class.new.en_la_ultima_semana?(Date.today - 7)).to eq false
    end
  end
end
