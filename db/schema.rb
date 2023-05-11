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

ActiveRecord::Schema[7.0].define(version: 2023_05_11_141018) do
  create_table "sleep_records", force: :cascade do |t|
    t.integer "duration"
    t.integer "user_id"
    t.datetime "stopped_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sleep_records_on_user_id"
    t.check_constraint "duration >= 0 OR duration IS NULL", name: "duration_check"
  end

  create_table "user_friends", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "friend_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "friend_user_id"], name: "index_user_friends_on_user_id_and_friend_user_id", unique: true
    t.index ["user_id"], name: "index_user_friends_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "sleep_records", "users"
  add_foreign_key "user_friends", "users"
  add_foreign_key "user_friends", "users", column: "friend_user_id"
end
