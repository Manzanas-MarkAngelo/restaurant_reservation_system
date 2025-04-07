class AddTableAssignmentIdToReservations < ActiveRecord::Migration[8.0]
  def change
    add_column :reservations, :table_assignment_id, :bigint
  end
end
