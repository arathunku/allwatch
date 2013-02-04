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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130204211225) do

  create_table "auctions", :force => true do |t|
    t.integer  "look_id"
    t.string   "name"
    t.decimal  "price_atm",  :precision => 10, :scale => 3
    t.decimal  "price_buy",  :precision => 10, :scale => 3
    t.datetime "end_time"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "auctions", ["look_id", "price_atm", "price_buy", "name", "end_time"], :name => "altered_auctions_index"

  create_table "looks", :force => true do |t|
    t.integer  "user_id"
    t.string   "name_query"
    t.text     "look_query", :limit => 255
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "looks", ["user_id", "name_query"], :name => "index_looks_on_user_id_and_name_query"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
