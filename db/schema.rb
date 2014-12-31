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

ActiveRecord::Schema.define(version: 20141228041655) do

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "user_id",               limit: 4
    t.string   "name",                  limit: 255
    t.string   "url",                   limit: 255
    t.text     "description",           limit: 65535
    t.boolean  "public",                limit: 1,     default: false
    t.string   "snapshot_file_name",    limit: 255
    t.string   "snapshot_content_type", limit: 255
    t.integer  "snapshot_file_size",    limit: 4
    t.datetime "snapshot_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                limit: 4,     default: 200
  end

  create_table "bookmarks_collections", id: false, force: :cascade do |t|
    t.integer "collection_id", limit: 4, null: false
    t.integer "bookmark_id",   limit: 4, null: false
  end

  create_table "collections", force: :cascade do |t|
    t.integer  "owner_id",          limit: 4
    t.string   "name",              limit: 255
    t.text     "description",       limit: 65535
    t.string   "icon_file_name",    limit: 255
    t.string   "icon_content_type", limit: 255
    t.integer  "icon_file_size",    limit: 4
    t.datetime "icon_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",            limit: 1,     default: false
  end

  create_table "collections_users", id: false, force: :cascade do |t|
    t.integer "collection_id", limit: 4, null: false
    t.integer "user_id",       limit: 4, null: false
  end

  create_table "profiles", id: false, force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.string   "first_name",          limit: 255
    t.string   "last_name",           limit: 255
    t.text     "description",         limit: 65535
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", unique: true, using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",         limit: 255,   null: false
    t.text     "value",       limit: 65535
    t.integer  "target_id",   limit: 4,     null: false
    t.string   "target_type", limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true, using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email", "reset_password_token", "unlock_token"], name: "index_users_on_email_and_reset_password_token_and_unlock_token", unique: true, using: :btree

end
