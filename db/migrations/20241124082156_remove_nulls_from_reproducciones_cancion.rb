require 'date'

Sequel.migration do
  up do
    today = Date.today
    self[:reproducciones_canciones].where(created_on: nil).update(created_on: today)

    alter_table(:reproducciones_canciones) do
      set_column_not_null :created_on
    end
  end

  down do
    alter_table(:reproducciones_canciones) do
      set_column_allow_null :created_on
    end

    self[:reproducciones_canciones].update(created_on: nil)
  end
end
