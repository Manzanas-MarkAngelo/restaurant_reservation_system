class AddTables < ActiveRecord::Migration[8.0]
  def change
    20.times do |i|
      Table.create(table_number: i + 1)
    end
  end
end
