class Recipe < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, :ingredients, :method, :category_id, presence: true

  mount_uploader :recipe_image, ImageUploader

  belongs_to :category
  belongs_to :user
end
