class TimeSlot < ApplicationRecord
  has_many :table_assignments
  has_many :tables, through: :table_assignments
  # Method to count the active tables
  def active_tables
    table_assignments.where(is_available: true).count
  end
end
