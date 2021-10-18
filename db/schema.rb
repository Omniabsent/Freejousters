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

ActiveRecord::Schema.define(version: 2021_10_18_003229) do

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "wanted_skills"
    t.integer "max_pay"
    t.date "expiration_date"
    t.boolean "remote"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "status", default: 1
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id", null: false
    t.string "presentation"
    t.integer "charges"
    t.integer "week_hours"
    t.integer "total_hours"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_proposals_on_project_id"
    t.index ["user_id"], name: "index_proposals_on_user_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.string "name"
    t.string "social_name"
    t.date "birth_date"
    t.string "major"
    t.string "bio"
    t.string "experience"
    t.string "picture"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "projects", "users"
  add_foreign_key "proposals", "projects"
  add_foreign_key "proposals", "users"
  add_foreign_key "user_profiles", "users"
end
