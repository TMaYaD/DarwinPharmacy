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

ActiveRecord::Schema.define(:version => 20100330215904) do

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "changes"
    t.integer  "version",        :default => 0
    t.datetime "created_at"
  end

  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "bill_items", :force => true do |t|
    t.integer  "bill_id"
    t.integer  "product_batch_id"
    t.integer  "quantity"
    t.decimal  "discount",         :precision => 4, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bills", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "modified_by_id"
    t.integer  "franchise_id"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "franchises", :force => true do |t|
    t.integer  "franchisee_id"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "dl"
    t.string   "tin"
  end

  create_table "franchises_users", :id => false, :force => true do |t|
    t.integer "franchise_id"
    t.integer "user_id"
  end

  create_table "product_batches", :force => true do |t|
    t.integer  "product_id"
    t.string   "batch_code"
    t.date     "mfg_date"
    t.date     "exp_date"
    t.decimal  "mrp",        :precision => 8, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "vat",        :precision => 4, :scale => 2
    t.decimal  "rate",       :precision => 8, :scale => 2
    t.integer  "pack"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "manufacturer"
    t.string   "schedule"
    t.text     "composition"
    t.string   "dosage_form"
    t.string   "strength"
    t.text     "common_uses"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_bill_items", :force => true do |t|
    t.integer  "purchase_bill_id"
    t.integer  "product_batch_id"
    t.decimal  "sale_quantity",                  :precision => 8,  :scale => 2
    t.decimal  "free_quantity",                  :precision => 8,  :scale => 2
    t.integer  "discount",         :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_bills", :force => true do |t|
    t.string   "bill_number"
    t.integer  "supplier_id"
    t.date     "due_date"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_bill_items", :force => true do |t|
    t.integer  "sale_bill_id"
    t.integer  "product_batch_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_bills", :force => true do |t|
    t.integer  "franchise_id"
    t.integer  "created_by_id"
    t.integer  "modified_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stock_inventories", :force => true do |t|
    t.integer  "franchise_id"
    t.integer  "product_batch_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "phone"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.boolean  "active",              :default => true
  end

end
