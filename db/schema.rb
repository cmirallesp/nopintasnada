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

ActiveRecord::Schema.define(:version => 20110226133851) do

  create_table "buyers", :force => true do |t|
    t.string   "nombre"
    t.string   "email"
    t.string   "idioma"
    t.string   "conocio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configurations", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "nombre"
    t.string   "ap1"
    t.string   "ap2"
    t.string   "email"
    t.string   "telf"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "model"
    t.string   "preu"
    t.string   "descripcio"
    t.string   "nom"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",    :default => false
  end

  create_table "promocodes", :force => true do |t|
    t.date     "end_date"
    t.float    "value"
    t.boolean  "state"
    t.integer  "days"
    t.string   "code"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string "username"
    t.string "password_salt"
    t.string "password_hash"
  end

end
