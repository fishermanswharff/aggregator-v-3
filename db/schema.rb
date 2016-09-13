# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160913032211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentication_providers", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentication_providers", ["name"], name: "index_authentication_providers_on_name", using: :btree

  create_table "feed_topics", force: :cascade do |t|
    t.integer  "feed_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_topics", ["feed_id"], name: "index_feed_topics_on_feed_id", using: :btree
  add_index "feed_topics", ["topic_id"], name: "index_feed_topics_on_topic_id", using: :btree

  create_table "feeds", force: :cascade do |t|
    t.text     "name",        default: "", null: false
    t.text     "url",         default: "", null: false
    t.text     "description", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["name"], name: "index_feeds_on_name", using: :btree
  add_index "feeds", ["url", "name"], name: "index_feeds_on_url_and_name", unique: true, using: :btree
  add_index "feeds", ["url"], name: "index_feeds_on_url", using: :btree

  create_table "followers", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followers", ["followable_type", "followable_id"], name: "index_followers_on_followable_type_and_followable_id", using: :btree
  add_index "followers", ["user_id", "followable_id", "followable_type"], name: "index_followers_on_user_followable_id_followable_type", unique: true, using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["name"], name: "index_topics_on_name", using: :btree

  create_table "user_authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "authentication_provider_id"
    t.string   "uid",                                     null: false
    t.string   "token",                                   null: false
    t.datetime "token_expires_at"
    t.jsonb    "params",                     default: {}, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_authentications", ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id", using: :btree
  add_index "user_authentications", ["params"], name: "index_user_authentications_on_params", using: :gin
  add_index "user_authentications", ["user_id"], name: "index_user_authentications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username",                           null: false
    t.integer  "role",                   default: 1, null: false
    t.string   "email",                              null: false
    t.string   "password_digest"
    t.string   "token"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["token"], name: "index_users_on_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "feed_topics", "feeds"
  add_foreign_key "feed_topics", "topics"
  add_foreign_key "user_authentications", "authentication_providers"
  add_foreign_key "user_authentications", "users"
end
