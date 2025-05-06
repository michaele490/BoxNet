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

ActiveRecord::Schema[7.2].define(version: 2025_05_06_192904) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxer_requests", force: :cascade do |t|
    t.bigint "coach_id", null: false
    t.bigint "boxer_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["boxer_id"], name: "index_boxer_requests_on_boxer_id"
    t.index ["coach_id", "boxer_id"], name: "index_boxer_requests_on_coach_id_and_boxer_id", unique: true
    t.index ["coach_id"], name: "index_boxer_requests_on_coach_id"
  end

  create_table "boxers", force: :cascade do |t|
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
    t.integer "overall_rating"
    t.integer "defence"
    t.integer "power"
    t.integer "speed"
    t.integer "iq"
    t.bigint "coach_id"
    t.string "weight_class"
    t.string "nickname"
    t.string "nationality"
    t.string "gender"
    t.float "height"
    t.float "reach"
    t.integer "stamina"
    t.index ["coach_id"], name: "index_boxers_on_coach_id"
    t.index ["email"], name: "index_boxers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_boxers_on_reset_password_token", unique: true
  end

  create_table "coaches", force: :cascade do |t|
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
    t.index ["email"], name: "index_coaches_on_email", unique: true
    t.index ["reset_password_token"], name: "index_coaches_on_reset_password_token", unique: true
  end

  create_table "editors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_editors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_editors_on_reset_password_token", unique: true
  end

  create_table "fights", force: :cascade do |t|
    t.integer "boxer_a_id"
    t.integer "boxer_b_id"
    t.date "fight_date"
    t.string "location"
    t.string "weight_class"
    t.integer "winner_id"
    t.string "method"
    t.string "status"
    t.boolean "draw"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "country"
  end

  create_table "spectators", force: :cascade do |t|
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
    t.index ["email"], name: "index_spectators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_spectators_on_reset_password_token", unique: true
    t.index ["username"], name: "index_spectators_on_username", unique: true
  end

  add_foreign_key "boxer_requests", "boxers"
  add_foreign_key "boxer_requests", "coaches"
  add_foreign_key "boxers", "coaches"
  add_foreign_key "fights", "boxers", column: "boxer_a_id"
  add_foreign_key "fights", "boxers", column: "boxer_b_id"
end
