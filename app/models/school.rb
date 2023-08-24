class School < ApplicationRecord
  has_many :students, dependent: :destroy
  has_many :users, dependent: :destroy
  validates :name, presence: true
  validates :code, presence: true
end
