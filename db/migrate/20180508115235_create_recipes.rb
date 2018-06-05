class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :description
      t.string :ingredients, :array => true
      t.string :method, :array => true
      t.string :recipe_image
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :recipes, :name, unique: true
  end
end
