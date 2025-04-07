class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot
  belongs_to :table_assignment

  delegate :table, to: :table_assignment

  validates :party_size, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :party_size_within_limit

  # Add callback to mark table assignment as reserved after a reservation is created
  after_create :mark_table_as_reserved

  private

  def party_size_within_limit
    if table_assignment && party_size.to_i > table_assignment.max_persons
      errors.add(:party_size, "exceeds the max capacity for the selected table.")
    end
  end

  def mark_table_as_reserved
    table_assignment.update(is_reserved: true)
  end
end
