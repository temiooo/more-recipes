class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  has_secure_password
end
