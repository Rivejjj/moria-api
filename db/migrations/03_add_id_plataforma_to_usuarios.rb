Sequel.migration do
  up do
    add_column :usuarios, :id_plataforma, Integer
  end

  down do
    drop_column :usuarios, :id_plataforma
  end
end
