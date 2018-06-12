class Favourite < ApplicationRecord
  validates :recipe_id, :favourite_status, :user_id, presence: true
  belongs_to :recipe
  belongs_to :user

  def self.existing(user_id, recipe_id)
    where(
      user_id: user_id,
      recipe_id: recipe_id
    )
  end

  def self.count_recipe_favourites(recipe_id)
    where(
      recipe_id: recipe_id
    ).count
  end
end
