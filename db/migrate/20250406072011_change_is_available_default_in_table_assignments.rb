class ChangeIsAvailableDefaultInTableAssignments < ActiveRecord::Migration[8.0]
  def change
    change_column_default :table_assignments, :is_available, from: nil, to: true
  end
end
