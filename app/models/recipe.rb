class Recipe < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, :ingredients, :method, :category_id, presence: true

  mount_uploader :recipe_image, ImageUploader

  belongs_to :category
  belongs_to :user

  has_many :favourites

  def self.with_favourites(recipes, user_id)
    recipe_with_favourites = []

    recipes.each do |recipe|
      recipe_with_favourites.push(
        recipe: recipe,
        favourite_count: Favourite.count_recipe_favourites(recipe.id),
        my_favourite: Favourite.existing(user_id, recipe.id).exists?,
        mine?: user_id == recipe.user_id
      )
    end

    recipe_with_favourites.reverse!
  end
end
