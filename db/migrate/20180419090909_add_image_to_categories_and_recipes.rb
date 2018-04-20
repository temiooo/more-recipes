class AddImageToCategoriesAndRecipes < ActiveRecord::Migration[5.1]
  def up
    add_attachment :categories, :category_image
    add_attachment :recipes, :recipe_image
  end

  def down
    remove_attachment :categories, :category_image
    remove_attachment :recipes, :recipe_image
  end
end
