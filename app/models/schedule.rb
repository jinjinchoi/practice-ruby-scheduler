class Schedule < ApplicationRecord
  belongs_to :tutor
  validates :start_date, :tutor_id, :active, presence: true
  validates_uniqueness_of :start_date, :scope => :tutor_id
end
