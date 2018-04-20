class Recipe < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, :ingredients, :method, presence: true

  belongs_to :user
  belongs_to :category

  has_attached_file :category_image, styles: { medium: "300x400>", thumb: "50x50>"}
  validates_attachment :category_image, presence: true
end
