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

ActiveRecord::Schema.define(version: 20140705230409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "subject_id",   null: false
    t.string   "subject_type", null: false
    t.integer  "user_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "activities", ["subject_id"], name: "index_activities_on_subject_id", using: :btree
  add_index "activities", ["subject_type"], name: "index_activities_on_subject_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "avatars", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "avatar"
    t.boolean  "avatar_processing"
    t.string   "avatar_tmp"
  end

  add_index "avatars", ["user_id"], name: "index_avatars_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "creation_id"
    t.string   "text"
    t.integer  "disqus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["creation_id"], name: "index_comments_on_creation_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "creations", force: true do |t|
    t.string   "name"
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image"
    t.string   "watermark"
    t.integer  "photos_count",    default: 0
    t.integer  "favorites_count", default: 0
    t.integer  "category_id"
  end

  add_index "creations", ["created_at"], name: "index_creations_on_created_at", using: :btree
  add_index "creations", ["user_id"], name: "index_creations_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "creation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["creation_id"], name: "index_favorites_on_creation_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "interests", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: true do |t|
    t.integer  "creation_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_tmp"
    t.boolean  "image_processing"
    t.string   "content_type"
    t.string   "original_filename"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "sha256"
  end

  add_index "photos", ["creation_id"], name: "index_photos_on_creation_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  add_index "taggings", ["tagger_type"], name: "index_taggings_on_tagger_type", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "tutorials", force: true do |t|
    t.string   "heading"
    t.text     "description"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image_url"
    t.string   "author"
    t.string   "author_url"
  end

  add_index "tutorials", ["user_id"], name: "index_tutorials_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "website"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "city"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "password_salt"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "invitation_token"
    t.string   "full_address"
    t.integer  "creations_count",                    default: 0
    t.boolean  "is_admin"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_interests", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "interest_id"
  end

  add_index "users_interests", ["interest_id", "user_id"], name: "index_users_interests_on_interest_id_and_user_id", using: :btree

end
