class School < ApplicationRecord
  has_many :students, dependent: :destroy
  validates :name, presence: true
  validates :code, presence: true
end
