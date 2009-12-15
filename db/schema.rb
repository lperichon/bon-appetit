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

ActiveRecord::Schema.define(:version => 20091215135709) do

  create_table "address_types", :force => true do |t|
    t.string "description"
  end

  create_table "addresses", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "type_id",     :default => 1
    t.string   "address"
    t.integer  "city_id"
    t.integer  "province_id"
    t.integer  "country_id"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string  "name"
    t.integer "province_id"
  end

  create_table "contacts", :force => true do |t|
    t.integer "restaurant_id", :null => false
    t.string  "first_name"
    t.string  "middle_name"
    t.string  "last_name"
    t.date    "birthday"
  end

  create_table "countries", :force => true do |t|
    t.string "name"
  end

  create_table "email_types", :force => true do |t|
    t.string "description"
  end

  create_table "emails", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "type_id",    :default => 1
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instant_messenger_protocols", :force => true do |t|
    t.string "name"
  end

  create_table "instant_messenger_types", :force => true do |t|
    t.string "description"
  end

  create_table "instant_messengers", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "protocol_id", :default => 1
    t.integer  "type_id",     :default => 1
    t.string   "nick"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "discount"
    t.decimal  "subtotal",   :precision => 8, :scale => 2
    t.decimal  "unit_price", :precision => 8, :scale => 2
    t.text     "notes"
  end

  create_table "orders", :force => true do |t|
    t.integer  "restaurant_id"
    t.datetime "generated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "discount"
    t.boolean  "closed"
    t.decimal  "total",         :precision => 8, :scale => 2
    t.text     "notes"
    t.integer  "table_id"
    t.integer  "contact_id"
  end

  create_table "phone_types", :force => true do |t|
    t.string "description"
  end

  create_table "phones", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "type_id",    :default => 1
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_types", :force => true do |t|
    t.integer  "restaurant_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "product_type_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price",           :precision => 8, :scale => 2
    t.string   "code"
  end

  create_table "provinces", :force => true do |t|
    t.string  "name"
    t.integer "country_id"
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manager_id"
    t.boolean  "include_tax"
    t.decimal  "tax_value",   :precision => 3, :scale => 2
  end

  create_table "restaurants_users", :id => false, :force => true do |t|
    t.integer "restaurant_id", :null => false
    t.integer "user_id",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email",                                  :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "admin",               :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",              :default => false, :null => false
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.date     "birthday"
  end

  create_table "website_types", :force => true do |t|
    t.string "description"
  end

  create_table "websites", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "type_id",    :default => 1
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
