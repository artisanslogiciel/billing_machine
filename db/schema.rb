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

ActiveRecord::Schema.define(version: 20140620101642) do

  create_table "activities", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.integer  "zip"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.string   "short_name"
    t.string   "country"
  end

  add_index "customers", ["entity_id"], name: "index_customers_on_entity_id"

  create_table "entities", force: true do |t|
    t.string   "name"
    t.string   "address1"
    t.string   "address2"
    t.integer  "zip"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unique_index",         default: 0
    t.boolean  "billing_machine",      default: false
    t.boolean  "time_machine",         default: false
    t.string   "customization_prefix"
  end

  add_index "entities", ["id", "unique_index"], name: "index_entities_on_id_and_unique_index", unique: true

  create_table "invoice_lines", force: true do |t|
    t.string   "label"
    t.decimal  "quantity"
    t.string   "unit"
    t.decimal  "unit_price"
    t.decimal  "total"
    t.integer  "invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invoice_lines", ["invoice_id"], name: "index_invoice_lines_on_invoice_id"

  create_table "invoices", force: true do |t|
    t.date     "date"
    t.integer  "customer_id"
    t.integer  "payment_term_id"
    t.string   "label"
    t.decimal  "total_duty"
    t.decimal  "vat"
    t.decimal  "total_all_taxes"
    t.decimal  "advance"
    t.decimal  "balance"
    t.integer  "entity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unique_index"
    t.decimal  "vat_rate"
  end

  add_index "invoices", ["customer_id"], name: "index_invoices_on_customer_id"
  add_index "invoices", ["entity_id"], name: "index_invoices_on_entity_id"

  create_table "payment_terms", force: true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
  end

  add_index "payment_terms", ["entity_id"], name: "index_payment_terms_on_entity_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
  end

  add_index "projects", ["entity_id"], name: "index_projects_on_entity_id"

  create_table "time_slices", force: true do |t|
    t.date     "day"
    t.integer  "project_id"
    t.decimal  "duration"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.integer  "user_id"
  end

  add_index "time_slices", ["user_id"], name: "index_time_slices_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name",             default: "",    null: false
    t.string   "last_name",              default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.integer  "manager_id"
    t.boolean  "billing_machine",        default: false
    t.boolean  "time_machine",           default: false
    t.boolean  "administrator",          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["entity_id"], name: "index_users_on_entity_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
