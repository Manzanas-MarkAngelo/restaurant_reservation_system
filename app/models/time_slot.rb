class TimeSlot < ApplicationRecord
  has_many :table_assignments
  has_many :tables, through: :table_assignments
end
