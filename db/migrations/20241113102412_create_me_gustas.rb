Sequel.migration do
  up do
    create_table(:me_gustas) do
      foreign_key :id_usuario, :usuarios, null: false, type: Integer
      foreign_key :id_contenido, :contenido, null: false, type: Integer
      primary_key %i[id_usuario id_contenido]
    end
  end

  down do
    drop_table(:me_gustas)
  end
end
