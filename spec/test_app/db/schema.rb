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

ActiveRecord::Schema.define(version: 20150827033638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fruit_bats", force: :cascade do |t|
    t.string "fangs"
  end

  create_table "local_credentials", force: :cascade do |t|
    t.string   "username",             null: false
    t.string   "encrypted_password",   null: false
    t.string   "salt",                 null: false
    t.string   "authenticatable_type", null: false
    t.integer  "authenticatable_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "local_credentials", ["authenticatable_type"], name: "index_local_credentials_on_authenticatable_type", using: :btree
  add_index "local_credentials", ["username"], name: "index_local_credentials_on_username", using: :btree

end
