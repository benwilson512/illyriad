# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101007225433) do

  create_table "alliances", :force => true do |t|
    t.integer  "game_id"
    t.string   "name"
    t.string   "ticker"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "founder_id"
    t.integer  "capital_id"
    t.datetime "founded"
    t.float    "tax_rate"
    t.datetime "set_tax_date"
    t.integer  "total_population"
  end

  create_table "calculations", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ownerships", :force => true do |t|
    t.integer  "player_id"
    t.integer  "town_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.integer  "game_id"
    t.string   "race"
    t.integer  "alliance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.string   "type"
    t.integer  "game_id"
    t.datetime "established"
    t.integer  "proposer_id"
    t.integer  "acceptor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "siege_forces", :force => true do |t|
    t.integer  "siege_id"
    t.integer  "town_id"
    t.integer  "destination_x"
    t.integer  "destination_y"
    t.string   "destination"
    t.integer  "troops"
    t.string   "role"
    t.string   "speed"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sieges", :force => true do |t|
    t.string   "name"
    t.integer  "target_id"
    t.datetime "time"
    t.string   "positions"
    t.integer  "creator_id"
    t.integer  "reinforce_time_delta",      :default => 0
    t.integer  "clearing_force_time_delta", :default => 0
    t.string   "roles"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "towns", :force => true do |t|
    t.string   "name"
    t.integer  "x"
    t.integer  "y"
    t.integer  "population"
    t.boolean  "capital"
    t.boolean  "alliance_capital"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "player_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.string   "password_salt",                      :default => "", :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
