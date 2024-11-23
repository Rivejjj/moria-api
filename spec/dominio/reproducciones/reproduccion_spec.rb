require 'spec_helper'
require_relative '../../../dominio/reproducciones/reproduccion'

describe Reproduccion do
  describe 'reproducido_por?' do
    it 'deberia devolver true si fue reproducido por el usuario' do
      usuario = instance_double('Usuario', es_el_mismo_usuario_que?: true)
      reproduccion = described_class.new(usuario, Date.new(2024, 11, 20))
      expect(reproduccion.reproducido_por?(usuario)).to be true
    end
  end

  describe 'fue_reproducido_hace_menos_de_una_semana?' do
    it 'deberia devolver true si fue reproducido hace menos de una semana' do
      proveedor_de_fecha = instance_double('ProveedorDeFecha', en_la_ultima_semana?: true)
      usuario = instance_double('Usuario')
      reproduccion = described_class.new(usuario, Date.new(2024, 11, 20))
      expect(reproduccion.fue_reproducido_hace_menos_de_una_semana?(proveedor_de_fecha)).to be true
    end

    it 'deberia devolver false si no fue reproducido hace menos de una semana' do
      proveedor_de_fecha = instance_double('ProveedorDeFecha', en_la_ultima_semana?: false)
      usuario = instance_double('Usuario')
      reproduccion = described_class.new(usuario, Date.new(2024, 11, 10))
      expect(reproduccion.fue_reproducido_hace_menos_de_una_semana?(proveedor_de_fecha)).to be false
    end
  end
end
