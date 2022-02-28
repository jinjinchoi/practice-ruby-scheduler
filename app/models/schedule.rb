class Schedule < ApplicationRecord
  belongs_to :tutor
  validates :start_time, :tutor_id, :active, presence: true
  validates :start_date, uniqueness: true
end
