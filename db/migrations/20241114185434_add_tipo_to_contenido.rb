Sequel.migration do
  up do
    add_column :contenido, :tipo, String

    from(:contenido).update(tipo: 'c')
  end

  down do
    drop_column :contenido, :tipo
  end
end
