class Table < ApplicationRecord
  # Remove the 'belongs_to :time_slot' because it’s redundant with the many-to-many association
  has_many :table_assignments
  has_many :time_slots, through: :table_assignments
  has_many :reservations

  validates :table_number, uniqueness: true
end
