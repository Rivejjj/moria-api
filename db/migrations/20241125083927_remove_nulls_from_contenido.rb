require 'date'

Sequel.migration do
  up do
    today = Date.today
    self[:contenido].where(created_on: nil).update(created_on: today)

    alter_table(:contenido) do
      set_column_not_null :created_on
    end
  end

  down do
    alter_table(:contenido) do
      set_column_allow_null :created_on
    end

    self[:contenido].update(created_on: nil)
  end
end
