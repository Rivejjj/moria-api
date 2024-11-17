Sequel.migration do
  up do
    create_table(:reproducciones_episodios) do
      foreign_key :id_usuario, :usuarios, null: false, type: Integer
      foreign_key :id_episodio, :episodios_podcast, null: false, type: Integer
      primary_key %i[id_usuario id_episodio]
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:reproducciones_episodios)
  end
end
