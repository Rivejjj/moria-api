Sequel.migration do
  up do
    alter_table(:contenido) do
      add_foreign_key :id_autor, :autores, null: true
    end

    from(:contenido).select(:autor).distinct.each do |row|
      id_autor = from(:autores).insert(nombre: row[:autor])
      from(:contenido).where(autor: row[:autor]).update(id_autor:)
    end

    alter_table(:contenido) do
      drop_column :autor
    end
  end

  down do
    alter_table(:contenido) do
      add_column :autor, String
    end

    from(:contenido).each do |row|
      autor = from(:autores).where(id: row[:id_autor]).get(:nombre)
      from(:contenido).where(id: row[:id]).update(autor:)
    end

    alter_table(:contenido) do
      drop_column :id_autor
    end
  end
end
