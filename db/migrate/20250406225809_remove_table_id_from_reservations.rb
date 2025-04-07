class RemoveTableIdFromReservations < ActiveRecord::Migration[8.0]
  def change
    remove_column :reservations, :table_id, :bigint
  end
end
