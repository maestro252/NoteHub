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

ActiveRecord::Schema.define(version: 20141112210029) do

  create_table "auths", force: true do |t|
    t.string   "token"
    t.date     "expires"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auths", ["user_id"], name: "auths_index_user_id", unique: true

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "start"
    t.date     "end"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["user_id"], name: "c_user_index"

  create_table "events", force: true do |t|
    t.string   "title"
    t.date     "date"
    t.text     "description"
    t.string   "recurrence"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["user_id", "date"], name: "e_user_index"

  create_table "friends", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "friends", ["user_id"], name: "f_user_index"

  create_table "notes", force: true do |t|
    t.string   "title"
    t.date     "date"
    t.text     "words"
    t.text     "lines"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pattern"
    t.string   "tags"
    t.boolean  "published"
    t.string   "username"
  end

  add_index "notes", ["course_id"], name: "n_course_index"
  add_index "notes", ["tags"], name: "tags_index"

  create_table "reminders", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "deadline"
    t.integer  "user_id"
    t.string   "priority"
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reminders", ["user_id", "priority"], name: "r_user_index"

  create_table "schedules", force: true do |t|
    t.integer  "course_id"
    t.string   "weekday"
    t.time     "time"
    t.string   "classroom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shares", force: true do |t|
    t.integer  "note_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "name"
    t.boolean  "active",             default: true, null: false
    t.string   "password_encrypted"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  add_index "users", ["username", "email"], name: "index_unique_username_email", unique: true

end
