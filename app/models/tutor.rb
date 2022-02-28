class Tutor < ApplicationRecord
  has_many :schedules
  validates :name, presence: true
end
