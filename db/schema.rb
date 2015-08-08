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

ActiveRecord::Schema.define(version: 20150808000102) do

  create_table "posts", force: :cascade do |t|
    t.string   "username",        null: false
    t.datetime "posted_at",       null: false
    t.string   "text"
    t.string   "image"
    t.string   "content_id",      null: false
    t.integer  "subscription_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "posts", ["subscription_id"], name: "index_posts_on_subscription_id"

  create_table "subscriptions", force: :cascade do |t|
    t.string   "twitter_id"
    t.string   "instagram_id"
    t.string   "profile_pic"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "subscriptions_users", force: :cascade do |t|
    t.integer "user_id",         null: false
    t.integer "subscription_id", null: false
  end

  add_index "subscriptions_users", ["subscription_id"], name: "index_subscriptions_users_on_subscription_id"
  add_index "subscriptions_users", ["user_id"], name: "index_subscriptions_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "email"
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
