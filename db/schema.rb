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

ActiveRecord::Schema[7.0].define(version: 2024_06_27_161815) do
  create_table "company_links", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_company_id", null: false
    t.string "name"
    t.string "href"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_company_id"], name: "index_company_links_on_user_company_id"
  end

  create_table "interview_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "interview_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interview_id"], name: "index_interview_items_on_interview_id"
  end

  create_table "interviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.bigint "job_application_id", null: false
    t.datetime "interview_time_from", null: false
    t.datetime "interview_time_to", null: false
    t.string "interview_type", null: false
    t.string "interview_url"
    t.string "interview_address"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_application_id"], name: "index_interviews_on_job_application_id"
    t.index ["user_id"], name: "index_interviews_on_user_id"
  end

  create_table "job_application_todos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_application_id", null: false
    t.string "name", null: false
    t.datetime "deadline"
    t.integer "status", null: false
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_application_id"], name: "index_job_application_todos_on_job_application_id"
    t.index ["user_id"], name: "index_job_application_todos_on_user_id"
  end

  create_table "job_applications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "user_company_id", null: false
    t.string "name", null: false
    t.string "job_type", null: false
    t.string "reason_for_personal_link"
    t.string "reason_for_interview_link"
    t.integer "annual_income"
    t.integer "level_of_interest", null: false
    t.integer "employment_type"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_company_id"], name: "index_job_applications_on_user_company_id"
    t.index ["user_id"], name: "index_job_applications_on_user_id"
  end

  create_table "user_companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "corporate_name", null: false
    t.string "corporate_number", null: false
    t.integer "industry_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_companies_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "company_links", "user_companies"
  add_foreign_key "interview_items", "interviews"
  add_foreign_key "interviews", "job_applications"
  add_foreign_key "interviews", "users"
  add_foreign_key "job_application_todos", "job_applications"
  add_foreign_key "job_application_todos", "users"
  add_foreign_key "job_applications", "user_companies"
  add_foreign_key "job_applications", "users"
  add_foreign_key "user_companies", "users"
end
