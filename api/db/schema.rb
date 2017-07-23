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

ActiveRecord::Schema.define(version: 20170723210942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gifts", force: :cascade do |t|
    t.string "name"
    t.string "note"
    t.string "link"
    t.integer "position"
    t.integer "status", default: 0
    t.bigint "recipient_id"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_gifts_on_author_id"
    t.index ["recipient_id"], name: "index_gifts_on_recipient_id"
  end

  create_table "gifts_comments", force: :cascade do |t|
    t.bigint "author_id"
    t.bigint "gift_id"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_gifts_comments_on_author_id"
    t.index ["gift_id"], name: "index_gifts_comments_on_gift_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.datetime "expires_at"
    t.string "token"
    t.string "invite_capacity", default: "50"
    t.bigint "inviting_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inviting_user_id"], name: "index_invitations_on_inviting_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "recipient_id"
    t.bigint "author_id_id"
    t.text "note"
    t.boolean "answered", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id_id"], name: "index_questions_on_author_id_id"
    t.index ["recipient_id"], name: "index_questions_on_recipient_id"
  end

  create_table "questions_comments", force: :cascade do |t|
    t.bigint "author_id_id"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id_id"], name: "index_questions_comments_on_author_id_id"
  end

  create_table "relations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "user_one_id"
    t.bigint "user_two_id"
    t.integer "status", default: 0
    t.bigint "action_user_id"
    t.bigint "relation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_user_id"], name: "index_relationships_on_action_user_id"
    t.index ["relation_id"], name: "index_relationships_on_relation_id"
    t.index ["user_one_id"], name: "index_relationships_on_user_one_id"
    t.index ["user_two_id"], name: "index_relationships_on_user_two_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.boolean "remember_me", default: false
    t.text "note"
    t.datetime "born_at"
    t.string "invitation_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "gifts", "users", column: "author_id"
  add_foreign_key "gifts", "users", column: "recipient_id"
  add_foreign_key "gifts_comments", "gifts"
  add_foreign_key "gifts_comments", "users", column: "author_id"
  add_foreign_key "invitations", "users", column: "inviting_user_id"
  add_foreign_key "questions", "users", column: "author_id_id"
  add_foreign_key "questions", "users", column: "recipient_id"
  add_foreign_key "questions_comments", "users", column: "author_id_id"
  add_foreign_key "relationships", "relations"
  add_foreign_key "relationships", "users", column: "action_user_id"
  add_foreign_key "relationships", "users", column: "user_one_id"
  add_foreign_key "relationships", "users", column: "user_two_id"
end
