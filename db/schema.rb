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

ActiveRecord::Schema[7.2].define(version: 2024_12_10_175012) do
  create_table "boxer_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.index ["email"], name: "index_boxer_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_boxer_users_on_reset_password_token", unique: true
  end

  create_table "boxers", force: :cascade do |t|
    t.integer "overall_rating"
    t.integer "defence"
    t.integer "power"
    t.integer "speed"
    t.integer "iq"
    t.integer "boxer_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boxer_user_id"], name: "index_boxers_on_boxer_user_id"
  end

  create_table "coach_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_coach_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_coach_users_on_reset_password_token", unique: true
  end

  create_table "coaches", force: :cascade do |t|
    t.integer "coach_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_user_id"], name: "index_coaches_on_coach_user_id"
  end

  add_foreign_key "boxers", "boxer_users"
  add_foreign_key "coaches", "coach_users"
end
