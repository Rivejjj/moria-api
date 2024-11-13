Sequel.migration do
  up do
    alter_table(:playlists_usuarios_contenido) do
      drop_constraint(:playlists_usuarios_contenido_orden_key, type: :unique)
    end
  end

  down do
    alter_table(:playlists_usuarios_contenido) do
      add_unique_constraint [:orden]
    end
  end
end
