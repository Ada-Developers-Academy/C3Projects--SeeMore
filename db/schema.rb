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

ActiveRecord::Schema.define(version: 20150809200842) do

  create_table "au_users", force: :cascade do |t|
    t.string   "provider"
    t.string   "name"
    t.string   "uid"
    t.string   "avatar"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "au_users_feeds", id: false, force: :cascade do |t|
    t.integer "au_user_id", null: false
    t.integer "feed_id",    null: false
  end

  add_index "au_users_feeds", ["au_user_id", "feed_id"], name: "index_au_users_feeds_on_au_user_id_and_feed_id"
  add_index "au_users_feeds", ["feed_id", "au_user_id"], name: "index_au_users_feeds_on_feed_id_and_au_user_id"

  create_table "feeds", force: :cascade do |t|
    t.string   "name"
    t.string   "avatar"
    t.string   "platform",         null: false
    t.integer  "platform_feed_id", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "description"
    t.string   "content"
    t.datetime "date_posted"
    t.integer  "feed_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "post_id"
  end

end
