class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  mount_uploader :category_image, ImageUploader

  has_many :recipes
end
