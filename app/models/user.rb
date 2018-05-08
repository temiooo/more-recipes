class User < ApplicationRecord
  validates :username, :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  has_secure_password

  has_many :recipes
end
