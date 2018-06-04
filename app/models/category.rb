class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_attached_file :category_image, styles: { medium: "300x400>", thumb: "50x50>"}
  validates_attachment :category_image, presence: true,
    :content_type => { :content_type =>  ["image/jpg", "image/jpeg", "image/gif", "image/png"] }

  has_many :recipes
end
