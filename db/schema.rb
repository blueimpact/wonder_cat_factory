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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170413144254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "accepted_at"
    t.datetime "paid_at"
  end

  add_index "bids", ["user_id", "product_id"], name: "index_bids_on_user_id_and_product_id", unique: true, using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["product_id"], name: "index_comments_on_product_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "type",       null: false
    t.integer  "bid_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "product_id"
  end

  add_index "events", ["bid_id"], name: "index_events_on_bid_id", using: :btree
  add_index "events", ["product_id"], name: "index_events_on_product_id", using: :btree

  create_table "instructions", force: :cascade do |t|
    t.string   "type",       null: false
    t.integer  "product_id"
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "instructions", ["product_id"], name: "index_instructions_on_product_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pictures", ["product_id"], name: "index_pictures_on_product_id", using: :btree

  create_table "product_messages", force: :cascade do |t|
    t.string   "subject",      null: false
    t.text     "body",         null: false
    t.integer  "product_id",   null: false
    t.integer  "message_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "product_messages", ["product_id", "message_type"], name: "index_product_messages_on_product_id_and_message_type", unique: true, using: :btree
  add_index "product_messages", ["product_id"], name: "index_product_messages_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.integer  "price"
    t.integer  "goal"
    t.date     "closes_on"
    t.integer  "bids_count",     default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "pictures_count", default: 0
    t.string   "external_url"
    t.datetime "started_at"
    t.datetime "goaled_at"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id", using: :btree

  create_table "stripe_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "publishable_key", null: false
    t.string   "secret_key",      null: false
    t.string   "stripe_user_id",  null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "stripe_accounts", ["user_id"], name: "index_stripe_accounts_on_user_id", using: :btree

  create_table "system_messages", force: :cascade do |t|
    t.string   "subject",      null: false
    t.text     "body",         null: false
    t.integer  "user_id",      null: false
    t.integer  "message_type", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "system_messages", ["message_type"], name: "index_system_messages_on_message_type", using: :btree
  add_index "system_messages", ["user_id", "message_type"], name: "index_system_messages_on_user_id_and_message_type", unique: true, using: :btree
  add_index "system_messages", ["user_id"], name: "index_system_messages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "label"
    t.boolean  "is_admin",               default: false, null: false
    t.boolean  "is_seller",              default: false, null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.date     "birthday"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bids", "products"
  add_foreign_key "bids", "users"
  add_foreign_key "comments", "products"
  add_foreign_key "comments", "users"
  add_foreign_key "events", "bids"
  add_foreign_key "events", "products"
  add_foreign_key "instructions", "products"
  add_foreign_key "pictures", "products"
  add_foreign_key "product_messages", "products"
  add_foreign_key "products", "users"
  add_foreign_key "stripe_accounts", "users"
  add_foreign_key "system_messages", "users"
end
