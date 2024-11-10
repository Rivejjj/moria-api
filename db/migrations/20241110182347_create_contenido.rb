Sequel.migration do
  up do
    create_table(:contenido) do
      primary_key :id
      String :nombre
      String :autor
      Integer :anio
      Integer :duracion
      String :genero
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:contenido)
  end
end
