# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120815002935) do

  create_table "ingredients", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipe_ingredients", :force => true do |t|
    t.string   "unit",          :null => false
    t.float    "amount",        :null => false
    t.integer  "recipe_id",     :null => false
    t.integer  "ingredient_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "recipes", :force => true do |t|
    t.integer  "owner_id",           :null => false
    t.string   "name",               :null => false
    t.integer  "cook_time",          :null => false
    t.integer  "servings",           :null => false
    t.text     "instructions",       :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "recipes", ["owner_id"], :name => "index_recipes_on_owner_id"

end
