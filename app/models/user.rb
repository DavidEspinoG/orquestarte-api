class User < ApplicationRecord
  has_secure_password
  has_many :students, dependent: :destroy
  validates :email, uniqueness: true, presence: true
  validates :password, :first_name, :last_name, presence: true
end
