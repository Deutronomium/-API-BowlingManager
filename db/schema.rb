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

ActiveRecord::Schema.define(version: 20150211174347) do

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drink_payments", force: true do |t|
    t.integer "drink_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "participation_id"
  end

  create_table "drinks", force: true do |t|
    t.string   "name"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
    t.datetime "date"
  end

  create_table "fine_payments", force: true do |t|
    t.integer "fine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "participation_id"
  end

  create_table "fines", force: true do |t|
    t.string "name"
    t.decimal "amount", precision: 8, scale: 2
    t.integer "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accept"
  end

  create_table "users", force: true do |t|
    t.string   "userName"
    t.string   "firstName"
    t.string   "lastName"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "street"
    t.string   "email"
    t.integer  "club_id"
    t.string   "password_digest"
    t.string   "phone_number"
  end

end
