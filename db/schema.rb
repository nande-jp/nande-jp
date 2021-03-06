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

ActiveRecord::Schema.define(version: 2020_03_07_135121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "question_id"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bookmarks_count", default: 0
    t.text "points"
    t.integer "shares_count", default: 0
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "asked_toos", force: :cascade do |t|
    t.bigint "question_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_asked_toos_on_question_id"
    t.index ["user_id"], name: "index_asked_toos_on_user_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "answer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_bookmarks_on_answer_id"
    t.index ["user_id", "answer_id"], name: "index_bookmarks_on_user_id_and_answer_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "children", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "age"
    t.integer "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.index ["user_id"], name: "index_children_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "following_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id", "following_id"], name: "index_follows_on_follower_id_and_following_id", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
    t.index ["following_id"], name: "index_follows_on_following_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answers_count", default: 0
    t.integer "asked_toos_count", default: 0
    t.integer "child_id"
    t.index ["child_id"], name: "index_questions_on_child_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "shares", force: :cascade do |t|
    t.bigint "answer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_shares_on_answer_id"
    t.index ["user_id", "answer_id"], name: "index_shares_on_user_id_and_answer_id", unique: true
    t.index ["user_id"], name: "index_shares_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.text "introduction"
    t.string "prefecture"
    t.string "city"
    t.integer "questions_count", default: 0
    t.integer "answers_count", default: 0
    t.integer "followers_count", default: 0
    t.integer "followings_count", default: 0
    t.integer "children_count", default: 0
    t.string "avatar"
    t.integer "gender"
    t.integer "age"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
