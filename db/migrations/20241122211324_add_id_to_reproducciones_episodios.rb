Sequel.migration do
  up do
    alter_table(:reproducciones_episodios) do
      drop_constraint(:reproducciones_episodios_pkey, type: :primary_key)
    end

    alter_table(:reproducciones_episodios) do
      add_column :id, Integer, serial: true, null: false, primary_key: true
    end

    from(:reproducciones_episodios).each_with_index do |row, index|
      from(:reproducciones_episodios).where(id_usuario: row[:id_usuario], id_episodio: row[:id_episodio]).update(id: index + 1)
    end
  end

  down do
    alter_table(:reproducciones_episodios) do
      drop_column :id
      drop_constraint(:reproducciones_episodios_pkey, type: :primary_key)
      add_primary_key %i[id_usuario id_episodio]
    end
  end
end
