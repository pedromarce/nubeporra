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

ActiveRecord::Schema.define(:version => 20130816040305) do

  create_table "bets", :force => true do |t|
    t.string   "score1"
    t.string   "score2"
    t.string   "score3"
    t.datetime "betTime"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "score_type_1_id"
    t.integer  "score_type_2_id"
    t.integer  "score_type_3_id"
    t.integer  "scoretype1_id"
    t.integer  "scoretype2_id"
    t.integer  "scoretype3_id"
    t.integer  "scoretype_id"
  end

  create_table "games", :force => true do |t|
    t.string   "description"
    t.string   "score1"
    t.string   "score2"
    t.string   "score3"
    t.datetime "closeTime"
    t.datetime "gameTime"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "scoretype_id"
    t.integer  "numscore"
  end

  create_table "score_type_values", :force => true do |t|
    t.integer  "score_type_id"
    t.string   "value"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "score_type_values", ["score_type_id"], :name => "index_score_type_values_on_scoreType_id"

  create_table "score_types", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "scoretypes", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "scoretypevalues", :force => true do |t|
    t.string   "value"
    t.integer  "scoretype_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "scoretypevalues", ["scoretype_id"], :name => "index_scoretypevalues_on_scoretype_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
