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

ActiveRecord::Schema.define(version: 20160413091033) do

  create_table "accounts", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "twitter_id",      limit: 255
    t.string   "display_name",    limit: 255
    t.integer  "followers_count", limit: 4
    t.integer  "following_count", limit: 4
    t.integer  "party_id",        limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "accounts", ["party_id"], name: "index_accounts_on_party_id", using: :btree

  create_table "api_call_logs", force: :cascade do |t|
    t.string   "call_description", limit: 255
    t.string   "call_date_time",   limit: 255
    t.boolean  "successful"
    t.string   "end_point_path",   limit: 255
    t.string   "twitter_handle",   limit: 255
    t.integer  "records_inserted", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "parties", force: :cascade do |t|
    t.string   "party_name",   limit: 255
    t.string   "party_colour", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "twitter_relationships", force: :cascade do |t|
    t.string   "follower",   limit: 255
    t.string   "followed",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "accounts", "parties"
end
