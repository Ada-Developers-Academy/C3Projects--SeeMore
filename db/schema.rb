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

ActiveRecord::Schema.define(version: 20150812174826) do

  create_table "grams", force: :cascade do |t|
    t.string   "tags"
    t.string   "media_type"
    t.string   "created_time"
    t.string   "link"
    t.integer  "likes"
    t.string   "image_url"
    t.string   "caption"
    t.string   "ig_id"
    t.string   "ig_username"
    t.string   "ig_user_pic"
    t.string   "ig_user_id"
    t.string   "ig_user_fullname"
    t.integer  "instagram_user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "instagram_users", force: :cascade do |t|
    t.string   "username"
    t.string   "profile_pic"
    t.string   "ig_user_id"
    t.string   "fullname"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "instagram_users_users", id: false, force: :cascade do |t|
    t.integer "instagram_user_id"
    t.integer "user_id"
  end

  add_index "instagram_users_users", ["instagram_user_id"], name: "index_instagram_users_users_on_instagram_user_id"
  add_index "instagram_users_users", ["user_id"], name: "index_instagram_users_users_on_user_id"

  create_table "tw_users", force: :cascade do |t|
    t.string   "tw_user_id_str"
    t.string   "user_name"
    t.string   "profile_image_url"
    t.string   "screen_name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "tw_users_users", id: false, force: :cascade do |t|
    t.integer "tw_user_id", null: false
    t.integer "user_id",    null: false
  end

  add_index "tw_users_users", ["tw_user_id", "user_id"], name: "index_tw_users_users_on_tw_user_id_and_user_id"
  add_index "tw_users_users", ["user_id", "tw_user_id"], name: "index_tw_users_users_on_user_id_and_tw_user_id"

  create_table "tweets", force: :cascade do |t|
    t.string   "tw_id_str"
    t.string   "tw_text"
    t.string   "created_time"
    t.integer  "tw_retweet_count"
    t.integer  "tw_favorite_count"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "tw_user_id_str"
    t.integer  "tw_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "uid"
    t.string   "provider"
    t.string   "avatar_url"
  end

end
