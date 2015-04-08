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

ActiveRecord::Schema.define(:version => 20150408044803) do

  create_table "appprices", :force => true do |t|
    t.string   "name"
    t.string   "store"
    t.string   "price"
    t.integer  "fullrank_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "fullranks", :force => true do |t|
    t.string   "apptype"
    t.integer  "rank"
    t.string   "name"
    t.text     "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "fullratings", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.string   "compatibility"
    t.string   "category"
    t.string   "updated_date"
    t.string   "size"
    t.string   "seller"
    t.string   "rated"
    t.string   "requirements"
    t.string   "bundleid"
    t.string   "average_current"
    t.string   "total_current"
    t.string   "average_all"
    t.string   "total_all"
    t.string   "current1"
    t.string   "current2"
    t.string   "current3"
    t.string   "current4"
    t.string   "current5"
    t.string   "all1"
    t.string   "all2"
    t.string   "all3"
    t.string   "all4"
    t.string   "all5"
    t.integer  "fullrank_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "rankings", :force => true do |t|
    t.string   "apptype"
    t.integer  "rank"
    t.string   "name"
    t.text     "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.string   "average_current"
    t.string   "total_current"
    t.string   "average_all"
    t.string   "total_all"
    t.string   "current1"
    t.string   "current2"
    t.string   "current3"
    t.string   "current4"
    t.string   "current5"
    t.string   "all1"
    t.string   "all2"
    t.string   "all3"
    t.string   "all4"
    t.string   "all5"
    t.integer  "ranking_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "searches", :force => true do |t|
    t.string   "name"
    t.text     "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "searchratings", :force => true do |t|
    t.string   "name"
    t.string   "store"
    t.string   "price"
    t.string   "country"
    t.string   "compatibility"
    t.string   "category"
    t.string   "updated_date"
    t.string   "size"
    t.string   "seller"
    t.string   "rated"
    t.string   "requirements"
    t.string   "bundleid"
    t.string   "average_current"
    t.string   "total_current"
    t.string   "average_all"
    t.string   "total_all"
    t.string   "current1"
    t.string   "current2"
    t.string   "current3"
    t.string   "current4"
    t.string   "current5"
    t.string   "all1"
    t.string   "all2"
    t.string   "all3"
    t.string   "all4"
    t.string   "all5"
    t.integer  "search_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
