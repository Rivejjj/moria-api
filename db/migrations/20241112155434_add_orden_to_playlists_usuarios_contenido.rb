Sequel.migration do
  up do
    add_column :playlists_usuarios_contenido, :orden, Integer, null: false, unique: true
  end

  down do
    drop_column :playlists_usuarios_contenido, :orden
  end
end
