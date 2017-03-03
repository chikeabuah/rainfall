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

ActiveRecord::Schema.define(version: 20170217164654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sessions", force: true do |t|
    t.string   "current_status",                         null: false
    t.float    "experience_years",                       null: false
    t.boolean  "cs_major",                               null: false
    t.string   "language",               default: "C",   null: false
    t.string   "access_key",                             null: false
    t.boolean  "coding_access_revoked",  default: false
    t.boolean  "lottery_access_revoked", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "snapshots", force: true do |t|
    t.text     "body",        null: false
    t.integer  "session_id",  null: false
    t.datetime "recorded_at", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
