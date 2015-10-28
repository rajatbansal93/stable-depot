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

ActiveRecord::Schema.define(version: 20151028061713) do

  create_table "addresses", force: :cascade do |t|
    t.string   "state",      limit: 255
    t.string   "city",       limit: 255
    t.string   "country",    limit: 255
    t.string   "pincode",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "line_items_count", limit: 4, default: 0
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.integer  "count",              limit: 4
    t.integer  "parent_category_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "deals", force: :cascade do |t|
    t.string "name",                 limit: 255
    t.string "discount",             limit: 255
    t.date   "valid_upto"
    t.string "max_allowed_discount", limit: 255
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "person_id",  limit: 4
  end

  add_index "departments", ["person_id"], name: "index_departments_on_person_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "cart_id",    limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "quantity",   limit: 4, default: 1
    t.integer  "order_id",   limit: 4
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "address",    limit: 65535
    t.string   "email",      limit: 255
    t.string   "pay_type",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id",    limit: 4
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "age",                    precision: 10
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",           limit: 255
    t.text     "description",     limit: 65535
    t.string   "image_url",       limit: 255
    t.decimal  "price",                         precision: 8, scale: 2
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.boolean  "enabled",                                               default: false
    t.integer  "line_item_count", limit: 4,                             default: 0,     null: false
    t.decimal  "discount_price",                precision: 8, scale: 2
    t.string   "permalink",       limit: 255
    t.integer  "category_id",     limit: 4
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.decimal  "rating",               precision: 3, scale: 2
    t.integer  "product_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "ratings", ["product_id"], name: "index_ratings_on_product_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "samples", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "part_number", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "email",           limit: 255
  end

  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "ratings", "products"
  add_foreign_key "ratings", "users"
end
