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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160206002746) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "factories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.string   "name"
    t.integer  "number"
    t.datetime "time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "comment"
  end

  create_table "restaurants", force: :cascade do |t|
    t.integer  "owner_id"
    t.integer  "category_id"
    t.string   "name"
    t.string   "address"
    t.string   "phone_number"
    t.string   "picture"
    t.text     "description"
    t.integer  "opening_time"
    t.integer  "closing_time"
    t.integer  "capacity"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
