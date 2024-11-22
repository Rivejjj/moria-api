Sequel.migration do
  up do
    create_table(:autores) do
      primary_key :id
      String :nombre
      String :id_externo
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:autores)
  end
end
