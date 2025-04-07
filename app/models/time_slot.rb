class TimeSlot < ApplicationRecord
  has_many :table_assignments, dependent: :destroy
  has_many :tables, through: :table_assignments

  validates :start_time, :end_time, :max_tables, presence: true

  validate :unique_start_time_for_date

  # Method to count the active tables
  def active_tables
    table_assignments.where(is_available: true).count
  end

  def unreserved_tables
    table_assignments.where(is_reserved: false).count
  end

  private

  # Custom method to check if the start time is unique for the same date
  def unique_start_time_for_date
    return if start_time.blank? || date.blank?

    existing_time_slot = TimeSlot.where(date: date, start_time: start_time)
    existing_time_slot = existing_time_slot.where.not(id: id) if persisted?

    if existing_time_slot.exists?
      errors.add(:start_time, "is already taken for this date")
    end
  end
end
