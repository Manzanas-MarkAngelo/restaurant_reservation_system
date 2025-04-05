class TableAssignment < ApplicationRecord
  belongs_to :table
  belongs_to :time_slot
end
