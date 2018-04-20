# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180419090909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "category_image_file_name"
    t.string "category_image_content_type"
    t.integer "category_image_file_size"
    t.datetime "category_image_updated_at"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "ingredients", array: true
    t.string "method", array: true
    t.bigint "categories_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recipe_image_file_name"
    t.string "recipe_image_content_type"
    t.integer "recipe_image_file_size"
    t.datetime "recipe_image_updated_at"
    t.index ["categories_id"], name: "index_recipes_on_categories_id"
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.integer "phonenumber"
    t.string "resetPasswordToken"
    t.datetime "resetpasswordExpires"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "recipes", "categories", column: "categories_id"
  add_foreign_key "recipes", "users"
end
