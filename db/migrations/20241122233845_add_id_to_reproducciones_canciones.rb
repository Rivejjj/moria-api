Sequel.migration do
  up do
    alter_table(:reproducciones_canciones) do
      drop_constraint(:reproducciones_pkey, type: :primary_key)
    end

    alter_table(:reproducciones_canciones) do
      add_column :id, Integer, serial: true, null: false, primary_key: true
    end

    from(:reproducciones_canciones).each_with_index do |row, index|
      from(:reproducciones_canciones).where(id_usuario: row[:id_usuario], id_contenido: row[:id_contenido]).update(id: index + 1)
    end
  end

  down do
    alter_table(:reproducciones_canciones) do
      drop_column :id
      drop_constraint(:reproducciones_pkey, type: :primary_key)
      add_primary_key %i[id_usuario id_contenido]
    end
  end
end
