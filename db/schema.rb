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

ActiveRecord::Schema.define(:version => 20120819045838) do

  create_table "app_categories", :force => true do |t|
    t.integer  "app_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "app_categories", ["app_id"], :name => "index_app_categories_on_app_id"
  add_index "app_categories", ["category_id"], :name => "index_app_categories_on_category_id"

  create_table "app_ranks", :force => true do |t|
    t.integer  "app_id"
    t.integer  "category_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "app_ranks", ["app_id"], :name => "index_app_ranks_on_app_id"
  add_index "app_ranks", ["category_id"], :name => "index_app_ranks_on_category_id"
  add_index "app_ranks", ["rank"], :name => "index_app_ranks_on_rank"

  create_table "apps", :force => true do |t|
    t.string   "appname"
    t.integer  "company_id"
    t.string   "app_id"
    t.string   "desc"
    t.string   "img"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["app_id"], :name => "index_apps_on_app_id"
  add_index "apps", ["company_id"], :name => "index_apps_on_company_id"

  create_table "categories", :force => true do |t|
    t.string   "category_name"
    t.string   "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["category_name"], :name => "index_categories_on_category_name"

  create_table "companies", :force => true do |t|
    t.string   "company_name"
    t.string   "company_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["company_name"], :name => "index_companies_on_company_name"

  create_table "users", :force => true do |t|
    t.string   "user_id",                :limit => 200
    t.string   "full_name",              :limit => 250
    t.string   "telephone_number",       :limit => 30
    t.string   "city",                   :limit => 250
    t.string   "country",                :limit => 50
    t.string   "mail",                   :limit => 200
    t.string   "mobile",                 :limit => 30
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
