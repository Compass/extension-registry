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

ActiveRecord::Schema.define(:version => 20111008182057) do

  create_table "extensions", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "ruby_gem"
    t.text     "ruby_gem_cache"
    t.integer  "user_id"
    t.string   "homepage"
    t.string   "source_code"
    t.string   "documentation"
    t.string   "mailing_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "gem_version_cache"
    t.datetime "gem_version_last_updated"
    t.datetime "ruby_gem_cache_last_updted"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
