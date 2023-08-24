# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_24_163403) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "months", force: :cascade do |t|
    t.string "name"
    t.boolean "paid", default: false
    t.bigint "student_id", null: false
    t.bigint "school_year_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_year_id"], name: "index_months_on_school_year_id"
    t.index ["student_id"], name: "index_months_on_student_id"
  end

  create_table "school_years", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "inscription_date"
    t.boolean "active"
    t.date "leave_date"
    t.bigint "user_id", null: false
    t.bigint "school_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_students_on_school_id"
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "phone_number"
    t.boolean "is_admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "months", "school_years"
  add_foreign_key "months", "students"
  add_foreign_key "students", "schools"
  add_foreign_key "students", "users"
end
