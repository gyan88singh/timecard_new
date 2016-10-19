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

ActiveRecord::Schema.define(version: 20160927073227) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string   "department_name"
    t.string   "status"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "department_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "badge"
    t.string   "pin"
    t.string   "gender"
    t.string   "marital"
    t.string   "social_ins"
    t.date     "hire_date"
    t.date     "birth_date"
    t.date     "senor_date"
    t.date     "term_date"
    t.string   "emergency_name"
    t.string   "floater"
    t.integer  "home_address_id"
    t.integer  "work_address_id"
    t.string   "time_zone"
    t.integer  "common_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "login_details", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "login_time"
    t.string   "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_sheets", force: :cascade do |t|
    t.integer  "WORKED_ID"
    t.integer  "PAYROLL"
    t.datetime "PDATE"
    t.integer  "SHIFT"
    t.datetime "ON_TIME"
    t.datetime "OFF_TIME"
    t.string   "CODE"
    t.integer  "CODE_TYPE"
    t.integer  "LINE_NO"
    t.string   "PAY_TYPE"
    t.string   "DEPT_GROUP"
    t.string   "DEPARTMENT"
    t.string   "CENTRE"
    t.string   "POS"
    t.string   "DOCKET"
    t.integer  "QUANTITY"
    t.integer  "STD_RATE"
    t.integer  "HOURS"
    t.integer  "HOUR_TYPE"
    t.integer  "NO_OT_REC"
    t.integer  "JOB_PREM"
    t.integer  "AM_PREM_HR"
    t.integer  "PM_PREM_HR"
    t.boolean  "CALC_FLAG"
    t.string   "STATUS"
    t.boolean  "WAS_LL"
    t.integer  "OT_TYPE"
    t.boolean  "NOERASE"
    t.datetime "CLK_ON"
    t.datetime "CLK_OFF"
    t.integer  "UDF1"
    t.integer  "UDF2"
    t.string   "NOTE"
    t.string   "CENTRE1"
    t.integer  "POS1"
    t.string   "RDOCKET"
    t.boolean  "TDEFAULT"
    t.boolean  "FLAG1"
    t.boolean  "FLAG2"
    t.boolean  "FLAG3"
    t.boolean  "FLAG4"
    t.boolean  "FLAG5"
    t.integer  "RATE"
    t.integer  "AM_PREM_RATE"
    t.integer  "PM_PREM_RATE"
    t.integer  "JOB_ID"
    t.integer  "UDF_KEY"
    t.string   "OPERATION"
    t.string   "UDF3"
    t.string   "UDF4"
    t.integer  "PIECE_RATE"
    t.integer  "WORK_ORDER_ID"
    t.integer  "WORK_ITEM_ID"
    t.string   "WOI_CONTROL"
    t.string   "APPROVED_STATUS"
    t.string   "APPROVED_BY"
    t.datetime "APPROVED_TIME"
    t.string   "EXT_ATTR_1"
    t.string   "EXT_ATTR_2"
    t.string   "EXT_ATTR_3"
    t.string   "EXT_ATTR_4"
    t.string   "EXT_ATTR_5"
    t.string   "EXT_ATTR_6"
    t.datetime "EWA_1"
    t.datetime "EWA_2"
    t.datetime "EWA_3"
    t.datetime "EWA_4"
    t.datetime "EWA_5"
    t.datetime "EWA_6"
    t.datetime "EWA_7"
    t.datetime "EWA_8"
    t.datetime "EWA_9"
    t.datetime "EWA_10"
    t.datetime "EWA_11"
    t.datetime "EWA_12"
    t.datetime "EWA_13"
    t.datetime "EWA_14"
    t.datetime "EWA_15"
    t.datetime "EWA_16"
    t.datetime "EWA_17"
    t.datetime "EWA_18"
    t.datetime "EWA_19"
    t.datetime "EWA_20"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "domain_name"
    t.string   "email",         default: "", null: false
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "is_admin"
    t.string   "status"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
