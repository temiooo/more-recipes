class Recipe < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, :ingredients, :method, :category_id, presence: true

  has_attached_file :recipe_image, styles: { medium: "300x400>", thumb: "50x50>"}
  validates_attachment :recipe_image, presence: true,
    :content_type => { :content_type =>  ["image/jpg", "image/jpeg", "image/gif", "image/png"] }

  belongs_to :category
  belongs_to :user
end
