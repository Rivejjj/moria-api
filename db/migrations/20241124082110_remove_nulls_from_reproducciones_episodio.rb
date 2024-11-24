require 'date'

Sequel.migration do
  up do
    today = Date.today
    self[:reproducciones_episodios].where(created_on: nil).update(created_on: today)

    alter_table(:reproducciones_episodios) do
      set_column_not_null :created_on
    end
  end

  down do
    alter_table(:reproducciones_episodios) do
      set_column_allow_null :created_on
    end

    self[:reproducciones_episodios].update(created_on: nil)
  end
end
