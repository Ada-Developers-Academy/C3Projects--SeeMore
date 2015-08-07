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

ActiveRecord::Schema.define(version: 20150807165656) do

  create_table "tweets", force: :cascade do |t|
    t.string   "tw_user_id_str"
    t.string   "tw_user_name_str"
    t.string   "tw_user_profile_image_url"
    t.string   "tw_user_screen_name"
    t.string   "tw_id_str"
    t.string   "tw_text"
    t.string   "tw_created_at"
    t.integer  "tw_retweet_count"
    t.integer  "tw_favorite_count"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id"
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
