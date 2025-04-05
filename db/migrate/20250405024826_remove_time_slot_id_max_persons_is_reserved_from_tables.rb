class RemoveTimeSlotIdMaxPersonsIsReservedFromTables < ActiveRecord::Migration[8.0]
  def change
    remove_column :tables, :time_slot_id
    remove_column :tables, :max_persons
    remove_column :tables, :is_reserved
  end
end
