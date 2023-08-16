class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :password, :first_name, :last_name, :phone_number, presence: true

end