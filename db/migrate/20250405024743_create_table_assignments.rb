class CreateTableAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :table_assignments do |t|
      t.references :table, null: false, foreign_key: true
      t.references :time_slot, null: false, foreign_key: true
      t.integer :max_persons
      t.boolean :is_reserved

      t.timestamps
    end
  end
end
