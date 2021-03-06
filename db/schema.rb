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

ActiveRecord::Schema.define(version: 20151213213741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clippings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "collection_id"
    t.string   "picture_url"
    t.string   "histogram"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "external_id"
    t.integer  "external_created_time"
    t.integer  "linked_account_id"
    t.integer  "color_1",               default: 0
    t.integer  "color_2",               default: 0
    t.integer  "color_3",               default: 0
    t.integer  "color_4",               default: 0
    t.integer  "color_5",               default: 0
    t.integer  "color_6",               default: 0
    t.integer  "color_7",               default: 0
    t.integer  "color_8",               default: 0
    t.integer  "color_9",               default: 0
    t.integer  "color_10",              default: 0
    t.integer  "color_11",              default: 0
    t.integer  "color_12",              default: 0
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "linked_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "external_account_id"
    t.string   "external_user_id"
    t.string   "external_meta_info"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name"
    t.string   "username"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
