Sequel.migration do
  up do
    rename_table(:reproducciones, :reproducciones_canciones)
  end

  down do
    rename_table(:reproducciones_canciones, :reproducciones)
  end
end
