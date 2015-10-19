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

ActiveRecord::Schema.define(:version => 20151015093951) do

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
    t.text     "link"
    t.string   "name"
    t.text     "icon"
    t.string   "store"
    t.string   "price"
    t.text     "description"
    t.string   "country"
    t.float    "average_current"
    t.integer  "total_current"
    t.float    "average_all"
    t.integer  "total_all"
    t.integer  "current1"
    t.integer  "current2"
    t.integer  "current3"
    t.integer  "current4"
    t.integer  "current5"
    t.integer  "all1"
    t.integer  "all2"
    t.integer  "all3"
    t.integer  "all4"
    t.integer  "all5"
    t.text     "screenshot1"
    t.text     "screenshot2"
    t.text     "screenshot3"
    t.text     "screenshot4"
    t.text     "screenshot5"
    t.integer  "fullrank_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "mockupapps", :force => true do |t|
    t.string   "esearch"
    t.string   "regulatoryfocus"
    t.integer  "apporder"
    t.string   "appname"
    t.text     "description"
    t.text     "icon"
    t.text     "screenshot1"
    t.text     "screenshot2"
    t.text     "screenshot3"
    t.integer  "totalrating"
    t.string   "distribution"
    t.integer  "num_star5"
    t.integer  "num_star4"
    t.integer  "num_star3"
    t.integer  "num_star2"
    t.integer  "num_star1"
    t.float    "pct_star5"
    t.float    "pct_star4"
    t.float    "pct_star3"
    t.float    "pct_star2"
    t.float    "pct_star1"
    t.string   "price"
    t.integer  "subjectinfo_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "mockupreviews", :force => true do |t|
    t.string   "esearch"
    t.integer  "apporder"
    t.string   "appname"
    t.integer  "revieworder"
    t.integer  "star"
    t.text     "title"
    t.text     "author"
    t.text     "content"
    t.string   "date"
    t.integer  "mockupapp_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
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
    t.text     "link"
    t.string   "name"
    t.text     "icon"
    t.string   "store"
    t.string   "price"
    t.text     "description"
    t.string   "country"
    t.float    "average_current"
    t.integer  "total_current"
    t.float    "average_all"
    t.integer  "total_all"
    t.integer  "current1"
    t.integer  "current2"
    t.integer  "current3"
    t.integer  "current4"
    t.integer  "current5"
    t.integer  "all1"
    t.integer  "all2"
    t.integer  "all3"
    t.integer  "all4"
    t.integer  "all5"
    t.text     "screenshot1"
    t.text     "screenshot2"
    t.text     "screenshot3"
    t.text     "screenshot4"
    t.text     "screenshot5"
    t.integer  "ranking_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "realapps", :force => true do |t|
    t.text     "link"
    t.string   "name"
    t.text     "icon"
    t.string   "store"
    t.string   "price"
    t.text     "description"
    t.string   "country"
    t.float    "average_current"
    t.integer  "total_current"
    t.float    "average_all"
    t.integer  "total_all"
    t.integer  "current1"
    t.integer  "current2"
    t.integer  "current3"
    t.integer  "current4"
    t.integer  "current5"
    t.integer  "all1"
    t.integer  "all2"
    t.integer  "all3"
    t.integer  "all4"
    t.integer  "all5"
    t.string   "distribution"
    t.string   "compatibility"
    t.string   "category"
    t.string   "updated_date"
    t.string   "size"
    t.string   "seller"
    t.string   "rated"
    t.string   "requirements"
    t.string   "bundleid"
    t.text     "screenshot1"
    t.text     "screenshot2"
    t.text     "screenshot3"
    t.text     "screenshot4"
    t.text     "screenshot5"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "reviews", :force => true do |t|
    t.string   "name"
    t.integer  "star"
    t.text     "title"
    t.text     "author"
    t.text     "content"
    t.string   "date"
    t.string   "country"
    t.string   "version"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

  create_table "subjectinfos", :force => true do |t|
    t.string   "esearch"
    t.string   "regulatoryfocus"
    t.integer  "mobile_user"
    t.integer  "appstore"
    t.integer  "visit_frequency"
    t.integer  "app_expense"
    t.integer  "previous_experience"
    t.string   "ipaddress"
    t.datetime "starttime"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "surveys", :force => true do |t|
    t.string   "esearch"
    t.string   "regulatoryfocus"
    t.string   "age"
    t.integer  "gender"
    t.integer  "income"
    t.integer  "involvement1"
    t.integer  "involvement2"
    t.integer  "involvement3"
    t.integer  "rf1"
    t.integer  "rf2"
    t.integer  "rf3"
    t.integer  "rf4"
    t.integer  "rf5"
    t.integer  "rf6"
    t.integer  "rf7"
    t.datetime "endtime"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
