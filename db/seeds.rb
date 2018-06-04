# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories_image_path = "#{Rails.root}/app/assets/images/categories"

categories_list = [
  { name: "Rice", category_image: File.open("#{categories_image_path}/rice.jpg") },
  { name: "Potatoes", category_image: File.open("#{categories_image_path}/potatoes.jpg") },
  { name: "Soups & Stews", category_image: File.open("#{categories_image_path}/soup.jpg") },
  { name: "Plaintain", category_image: File.open("#{categories_image_path}/plaintain.jpg") },
  { name: "Yam", category_image: File.open("#{categories_image_path}/yam.jpg") },
  { name: "Fruits & Vegetables", category_image: File.open("#{categories_image_path}/vegetable.jpg") },
  { name: "Beans", category_image: File.open("#{categories_image_path}/beans.jpg") },
  { name: "Meat", category_image: File.open("#{categories_image_path}/meat.jpg") },
  { name: "Baked Goodies", category_image: File.open("#{categories_image_path}/baked.jpg") },
  { name: "Seafood", category_image: File.open("#{categories_image_path}/seafood.jpg") }
]

categories_list.each do |category|
  Category.create(name: category[:name], category_image: category[:category_image])
end
