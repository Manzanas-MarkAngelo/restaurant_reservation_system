class AddTimeSlotIdToTimeSlots < ActiveRecord::Migration[8.0]
  def change
    # Step 1: Add the time_slot_id column to the time_slots table
    add_column :time_slots, :time_slot_id, :integer

    # Step 2: Add the foreign key constraint
    add_foreign_key :time_slots, :time_slots, column: :time_slot_id, primary_key: :id
  end
end
