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

ActiveRecord::Schema.define(version: 20140729004900) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "start"
    t.date     "end"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["user_id"], name: "user_index"

  create_table "schedules", force: true do |t|
    t.string   "course_id"
    t.string   "weekday"
    t.time     "time"
    t.string   "classroom"
    t.string   "recurrence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["course_id"], name: "course_index"

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.boolean  "active",             default: true, null: false
    t.string   "password_encrypted"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username", "email"], name: "index_unique_username_email", unique: true

end
