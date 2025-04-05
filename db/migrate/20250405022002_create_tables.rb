class CreateTables < ActiveRecord::Migration[8.0]
  def change
    create_table :tables do |t|
      t.references :time_slot, null: false, foreign_key: true
      t.integer :table_number
      t.integer :max_persons
      t.boolean :is_reserved

      t.timestamps
    end
  end
end
