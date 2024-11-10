Sequel.migration do
  up do
    add_column :usuarios, :nombre, String, unique: true
  end

  down do
    drop_column :usuarios, :nombre
  end
end
