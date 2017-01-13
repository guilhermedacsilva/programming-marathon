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

ActiveRecord::Schema.define(version: 20170113160850) do

  create_table "marathons", force: :cascade do |t|
    t.string   "name",                         null: false
    t.boolean  "started",      default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.datetime "deleted_at"
    t.boolean  "registration", default: false
    t.boolean  "can_register", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                             null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "deleted_at"
    t.integer  "marathon_id"
    t.integer  "access",              default: 0,  null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
  end

  add_index "users", ["marathon_id"], name: "index_users_on_marathon_id"

end
