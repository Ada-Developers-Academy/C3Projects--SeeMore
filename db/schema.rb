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

ActiveRecord::Schema.define(version: 20150809205747) do

  create_table "grams", force: :cascade do |t|
    t.string   "uid",        null: false
    t.string   "body"
    t.string   "photo_url",  null: false
    t.datetime "gram_time",  null: false
    t.integer  "prey_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "grams", ["prey_id"], name: "index_grams_on_prey_id"

  create_table "prey", force: :cascade do |t|
    t.string   "name"
    t.string   "username"
    t.string   "provider",    null: false
    t.string   "uid",         null: false
    t.string   "photo_url"
    t.string   "profile_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "prey_stalkers", id: false, force: :cascade do |t|
    t.integer "prey_id",    null: false
    t.integer "stalker_id", null: false
  end

  add_index "prey_stalkers", ["prey_id", "stalker_id"], name: "index_prey_stalkers_on_prey_id_and_stalker_id"
  add_index "prey_stalkers", ["stalker_id", "prey_id"], name: "index_prey_stalkers_on_stalker_id_and_prey_id"

  create_table "stalkers", force: :cascade do |t|
    t.string   "username",   null: false
    t.string   "uid",        null: false
    t.string   "provider",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tweets", force: :cascade do |t|
    t.string   "uid",        null: false
    t.string   "body"
    t.datetime "tweet_time", null: false
    t.integer  "prey_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "url",        null: false
  end

  add_index "tweets", ["prey_id"], name: "index_tweets_on_prey_id"

end
