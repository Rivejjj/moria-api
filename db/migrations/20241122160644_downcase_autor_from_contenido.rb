Sequel.migration do
  up do
    from(:contenido).update(autor: Sequel.function(:lower, :autor))
  end

  down do
  end
end
