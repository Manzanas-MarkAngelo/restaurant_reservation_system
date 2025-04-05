class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot
  belongs_to :table

  validate :party_size_within_limit

  private

  def party_size_within_limit
    if table && party_size > table.max_persons
      errors.add(:party_size, "exceeds the max capacity for the selected table.")
    end
  end
end
