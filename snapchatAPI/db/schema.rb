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

ActiveRecord::Schema.define(version: 20160616132310) do

  create_table "friends", force: :cascade do |t|
    t.integer  "user_id1",   limit: 4
    t.integer  "user_id2",   limit: 4
    t.boolean  "accepted"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "snaps", force: :cascade do |t|
    t.integer  "sender_id",    limit: 4
    t.integer  "recipient_id", limit: 4
    t.integer  "duration",     limit: 4
    t.string   "file",         limit: 255
    t.boolean  "seen",                     null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "password",   limit: 255
    t.string   "email",      limit: 255
    t.string   "token",      limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
