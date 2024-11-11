Sequel.migration do
  up do
    create_table(:playlists_usuarios_contenido) do
      foreign_key :id_usuario, :usuarios, null: false, type: Integer
      foreign_key :id_contenido, :contenido, null: false, type: Integer
      primary_key %i[id_usuario id_contenido]
      Date :created_on
      Date :updated_on
    end
  end

  down do
    drop_table(:playlists_usuarios_contenido)
  end
end
