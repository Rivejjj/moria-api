Sequel.migration do
  up do
    create_table(:episodios_podcast) do
      primary_key :id
      Integer :numero_episodio
      Integer :id_podcast
      String :nombre
      Integer :duracion
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:episodios_podcast)
  end
end
