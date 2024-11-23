require 'spec_helper'
require_relative '../../../dominio/reproducciones/reproduccion'

describe Reproduccion do
  describe 'fue_reproducido_hace_menos_de_una_semana?' do
    it 'deberia devolver true si fue reproducido hace menos de una semana' do
      proveedor_de_fecha = instance_double('ProveedorDeFecha', fecha_actual: Date.new(2024, 11, 20))
      usuario = instance_double('Usuario')
      reproduccion = described_class.new(usuario, Date.new(2024, 11, 20))
      expect(reproduccion.fue_reproducido_hace_menos_de_una_semana?(proveedor_de_fecha)).to be true
    end

    it 'deberia devolver false si no fue reproducido hace menos de una semana' do
      proveedor_de_fecha = instance_double('ProveedorDeFecha', fecha_actual: Date.new(2024, 11, 20))
      usuario = instance_double('Usuario')
      reproduccion = described_class.new(usuario, Date.new(2024, 11, 10))
      expect(reproduccion.fue_reproducido_hace_menos_de_una_semana?(proveedor_de_fecha)).to be false
    end
  end
end
