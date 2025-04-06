class AddIsAvailableToTableAssignments < ActiveRecord::Migration[8.0]
  def change
    add_column :table_assignments, :is_available, :boolean
  end
end
