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

ActiveRecord::Schema.define(:version => 20100317151340) do

  create_table "address_type_translations", :force => true do |t|
    t.string   "locale"
    t.integer  "address_type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "address_types", :force => true do |t|
  end

  create_table "addresses", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "type_id",      :default => 1
    t.string   "address"
    t.integer  "city_id"
    t.integer  "country_id"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "lat"
    t.decimal  "lng"
    t.integer  "division1_id"
    t.integer  "division2_id"
    t.integer  "division3_id"
    t.integer  "division4_id"
  end

  create_table "cities", :force => true do |t|
    t.integer "country_id",                                                  :null => false
    t.integer "geonames_id",                                                 :null => false
    t.string  "name",                                                        :null => false
    t.decimal "latitude",                     :precision => 14, :scale => 8, :null => false
    t.decimal "longitude",                    :precision => 14, :scale => 8, :null => false
    t.string  "country_iso_code_two_letters"
    t.integer "geonames_timezone_id"
    t.string  "code"
    t.integer "division_id"
  end

  add_index "cities", ["code"], :name => "index_cities_on_code"
  add_index "cities", ["division_id"], :name => "index_cities_on_division_id"
  add_index "cities", ["geonames_id"], :name => "index_cities_on_geonames_id", :unique => true

  create_table "contacts", :force => true do |t|
    t.integer "restaurant_id", :null => false
    t.string  "first_name"
    t.string  "middle_name"
    t.string  "last_name"
    t.date    "birthday"
  end

  create_table "countries", :force => true do |t|
    t.string  "iso_code_two_letter",                   :null => false
    t.string  "iso_code_three_letter",                 :null => false
    t.integer "iso_number",                            :null => false
    t.string  "name",                                  :null => false
    t.string  "capital"
    t.string  "continent"
    t.integer "geonames_id",                           :null => false
    t.string  "alternate_names",       :limit => 5000
  end

  add_index "countries", ["geonames_id"], :name => "index_countries_on_geonames_id"
  add_index "countries", ["iso_code_two_letter"], :name => "index_countries_on_iso_code_two_letter", :unique => true

  create_table "divisions", :force => true do |t|
    t.integer "country_id",                                                                                 :null => false
    t.integer "parent_id"
    t.integer "level",                                                                       :default => 1
    t.string  "code",                                                                                       :null => false
    t.integer "geonames_id",                                                                                :null => false
    t.string  "name",                                                                                       :null => false
    t.string  "alternate_names",              :limit => 5000
    t.decimal "latitude",                                     :precision => 14, :scale => 8,                :null => false
    t.decimal "longitude",                                    :precision => 14, :scale => 8,                :null => false
    t.string  "country_iso_code_two_letters"
    t.integer "geonames_timezone_id"
  end

  add_index "divisions", ["code"], :name => "index_divisions_on_code"
  add_index "divisions", ["geonames_id"], :name => "index_divisions_on_geonames_id", :unique => true
  add_index "divisions", ["parent_id"], :name => "index_divisions_on_parent_id"

  create_table "email_type_translations", :force => true do |t|
    t.string   "locale"
    t.integer  "email_type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_types", :force => true do |t|
  end

  create_table "emails", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "type_id",    :default => 1
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identification_types", :force => true do |t|
    t.string "name"
  end

  create_table "identifications", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "type_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instant_messenger_protocols", :force => true do |t|
    t.string "name"
  end

  create_table "instant_messenger_type_translations", :force => true do |t|
    t.string   "locale"
    t.integer  "instant_messenger_type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instant_messenger_types", :force => true do |t|
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
    t.decimal  "discount",     :precision => 3, :scale => 2
    t.decimal  "subtotal",     :precision => 8, :scale => 2
    t.decimal  "unit_price",   :precision => 8, :scale => 2
    t.text     "notes"
    t.string   "product_name"
  end

  create_table "orders", :force => true do |t|
    t.integer  "restaurant_id"
    t.datetime "generated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "discount",             :precision => 3, :scale => 2
    t.boolean  "closed"
    t.decimal  "total",                :precision => 8, :scale => 2
    t.text     "notes"
    t.integer  "table_id"
    t.integer  "contact_id"
    t.string   "invoice_file_name"
    t.string   "invoice_content_type"
    t.integer  "invoice_file_size"
    t.datetime "invoice_updated_at"
    t.integer  "address_id"
    t.string   "contact_name"
    t.decimal  "subtotal",             :precision => 8, :scale => 2
  end

  create_table "phone_type_translations", :force => true do |t|
    t.string   "locale"
    t.integer  "phone_type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phone_types", :force => true do |t|
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

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "manager_id"
    t.boolean  "include_tax"
    t.decimal  "tax_value",   :precision => 3, :scale => 2
    t.string   "timezone"
  end

  create_table "restaurants_users", :id => false, :force => true do |t|
    t.integer "restaurant_id", :null => false
    t.integer "user_id",       :null => false
  end

  create_table "subscription_plans", :force => true do |t|
    t.string   "name",                      :null => false
    t.integer  "rate_cents", :default => 0
    t.integer  "interval",   :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_profiles", :force => true do |t|
    t.integer  "subscription_id"
    t.string   "state"
    t.string   "profile_key"
    t.string   "card_first_name"
    t.string   "card_last_name"
    t.string   "card_type"
    t.string   "card_display_number"
    t.date     "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_transactions", :force => true do |t|
    t.integer  "subscription_id", :null => false
    t.integer  "amount_cents"
    t.boolean  "success"
    t.string   "reference"
    t.string   "message"
    t.string   "action"
    t.text     "params"
    t.boolean  "test"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "subscriber_id",                  :null => false
    t.string   "subscriber_type",                :null => false
    t.integer  "plan_id"
    t.string   "state"
    t.date     "next_renewal_on"
    t.integer  "warning_level"
    t.integer  "balance_cents",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["next_renewal_on"], :name => "index_subscriptions_on_next_renewal_on"
  add_index "subscriptions", ["state"], :name => "index_subscriptions_on_state"
  add_index "subscriptions", ["subscriber_id"], :name => "index_subscriptions_on_subscriber_id"
  add_index "subscriptions", ["subscriber_type"], :name => "index_subscriptions_on_subscriber_type"

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
    t.string   "locale"
  end

  create_table "website_type_translations", :force => true do |t|
    t.string   "locale"
    t.integer  "website_type_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "website_types", :force => true do |t|
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
