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

ActiveRecord::Schema.define(version: 20150809210224) do

  create_table "instagram_posts", force: :cascade do |t|
    t.string   "post_id",      null: false
    t.integer  "instagram_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "instagram_posts", ["instagram_id"], name: "index_instagram_posts_on_instagram_id"

  create_table "instagrams", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "username",    null: false
    t.string   "provider_id", null: false
    t.string   "image_url"
  end

  create_table "instagrams_users", id: false, force: :cascade do |t|
    t.integer "instagram_id", null: false
    t.integer "user_id",      null: false
  end

  add_index "instagrams_users", ["instagram_id", "user_id"], name: "index_instagrams_users_on_instagram_id_and_user_id", unique: true

  create_table "tweet_posts", force: :cascade do |t|
    t.integer  "post_id"
    t.datetime "posted_at"
    t.text     "text"
    t.string   "media_url"
    t.integer  "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "username",    null: false
    t.string   "provider_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image_url"
  end

  create_table "tweets_users", id: false, force: :cascade do |t|
    t.integer "tweet_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "tweets_users", ["tweet_id", "user_id"], name: "index_tweets_users_on_tweet_id_and_user_id", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "uid"
    t.string   "provider"
    t.string   "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
