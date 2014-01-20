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

ActiveRecord::Schema.define(version: 20140120173710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "cnpj",         limit: 21
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact_mail"
    t.string   "subdomain"
    t.integer  "plan_id"
  end

  add_index "accounts", ["subdomain"], name: "index_accounts_on_subdomain", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "uf",         limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["uf"], name: "index_cities_on_uf", using: :btree

  create_table "classrooms", force: true do |t|
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.integer  "teacher_id"
  end

  add_index "classrooms", ["subject_id"], name: "index_classrooms_on_subject_id", using: :btree
  add_index "classrooms", ["teacher_id"], name: "index_classrooms_on_teacher_id", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.integer  "classroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["classroom_id"], name: "index_entries_on_classroom_id", using: :btree

  create_table "entry_settings", force: true do |t|
    t.integer  "entry_id"
    t.integer  "topic_id"
    t.boolean  "follow",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entry_settings", ["entry_id"], name: "index_entry_settings_on_entry_id", using: :btree
  add_index "entry_settings", ["topic_id"], name: "index_entry_settings_on_topic_id", using: :btree

  create_table "exams", force: true do |t|
    t.integer  "period"
    t.integer  "classroom_id"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "exam_date"
    t.integer  "account_id"
  end

  add_index "exams", ["account_id"], name: "index_exams_on_account_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "plans", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
    t.integer  "students_number"
  end

  create_table "student_exams", force: true do |t|
    t.integer  "student_id"
    t.integer  "exam_id"
    t.float    "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
  end

  create_table "topics", force: true do |t|
    t.integer  "classroom_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_groups", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_groups", ["group_id"], name: "index_user_groups_on_group_id", using: :btree
  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "enrollment"
    t.string   "phone_number"
    t.string   "cellphone_number"
    t.date     "birth_date"
    t.string   "address"
    t.string   "address_number"
    t.string   "address_complement"
    t.string   "address_city"
    t.string   "address_state"
    t.integer  "account_id"
    t.boolean  "student"
    t.boolean  "teacher"
    t.boolean  "employee"
    t.boolean  "admin"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
