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

ActiveRecord::Schema[8.0].define(version: 2025_04_05_024826) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "time_slot_id", null: false
    t.bigint "table_id", null: false
    t.integer "party_size"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_reservations_on_table_id"
    t.index ["time_slot_id"], name: "index_reservations_on_time_slot_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "table_assignments", force: :cascade do |t|
    t.bigint "table_id", null: false
    t.bigint "time_slot_id", null: false
    t.integer "max_persons"
    t.boolean "is_reserved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["table_id"], name: "index_table_assignments_on_table_id"
    t.index ["time_slot_id"], name: "index_table_assignments_on_time_slot_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "table_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_slots", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.time "end_time"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.string "contact_number"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "reservations", "tables"
  add_foreign_key "reservations", "time_slots"
  add_foreign_key "reservations", "users"
  add_foreign_key "table_assignments", "tables"
  add_foreign_key "table_assignments", "time_slots"
end
