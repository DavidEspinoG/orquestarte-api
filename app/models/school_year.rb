class SchoolYear < ApplicationRecord
  has_many :months
  validates :name, presence: true
end
