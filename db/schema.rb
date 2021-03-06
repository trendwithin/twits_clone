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

ActiveRecord::Schema.define(version: 20160317003636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "published",  default: "f"
    t.integer  "status",     default: 0
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "chirps", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chirps", ["user_id", "created_at"], name: "index_chirps_on_user_id_and_created_at", using: :btree
  add_index "chirps", ["user_id"], name: "index_chirps_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["blog_id"], name: "index_comments_on_blog_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "trade_logs", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "trade_opened_at"
    t.string   "symbol"
    t.integer  "position_size"
    t.float    "entry_price"
    t.float    "stop"
    t.float    "target"
    t.datetime "exit_one_on"
    t.integer  "exit_one_shares"
    t.float    "exit_one_price"
    t.datetime "exit_two_on"
    t.integer  "exit_two_shares"
    t.float    "exit_two_price"
    t.datetime "exit_three_on"
    t.integer  "exit_three_shares"
    t.float    "exit_three_price"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "trade_logs", ["user_id"], name: "index_trade_logs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",             null: false
    t.string   "encrypted_password",     default: "",             null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,              null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.string   "role",                   default: "unregistered"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "chirps", "users"
  add_foreign_key "comments", "blogs"
  add_foreign_key "comments", "users"
  add_foreign_key "trade_logs", "users"
end
