class CreateFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favourites do |t|
      t.references :recipe, foreign_key: true
      t.boolean :favourite_status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
