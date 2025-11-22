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

ActiveRecord::Schema[8.1].define(version: 2025_11_22_090947) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "image_url"
    t.string "language", default: "English", null: false
    t.string "language_code", default: "en-US", null: false
    t.string "name"
    t.text "personality"
    t.datetime "updated_at", null: false
    t.string "voice_id"
    t.index ["language"], name: "index_avatars_on_language"
    t.index ["language_code"], name: "index_avatars_on_language_code"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "avatar_id", null: false
    t.datetime "created_at", null: false
    t.integer "difficulty_level"
    t.bigint "learning_path_id"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["avatar_id"], name: "index_conversations_on_avatar_id"
    t.index ["learning_path_id"], name: "index_conversations_on_learning_path_id"
  end

  create_table "learning_paths", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "difficulty_level", default: 1, null: false
    t.integer "estimated_hours"
    t.boolean "is_published", default: true
    t.string "title", null: false
    t.integer "total_lessons"
    t.datetime "updated_at", null: false
    t.index ["difficulty_level"], name: "index_learning_paths_on_difficulty_level"
    t.index ["is_published"], name: "index_learning_paths_on_is_published"
  end

  create_table "messages", force: :cascade do |t|
    t.string "audio_url"
    t.text "content"
    t.bigint "conversation_id", null: false
    t.datetime "created_at", null: false
    t.string "sender_type"
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
  end

  create_table "target_languages", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_target_languages_on_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "conversations", "avatars"
  add_foreign_key "conversations", "learning_paths"
  add_foreign_key "messages", "conversations"
end
