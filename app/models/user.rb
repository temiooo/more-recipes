class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :phonenumber, presence: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  has_secure_password

  has_many :recipes
end
