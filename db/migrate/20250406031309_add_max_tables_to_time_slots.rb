class AddMaxTablesToTimeSlots < ActiveRecord::Migration[8.0]
  def change
    add_column :time_slots, :max_tables, :integer
  end
end
