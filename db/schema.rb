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

ActiveRecord::Schema.define(version: 20141206152512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "activities", force: :cascade do |t|
    t.integer  "subject_id",               null: false
    t.string   "subject_type", limit: 255, null: false
    t.integer  "user_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "activities", ["subject_id"], name: "index_activities_on_subject_id", using: :btree
  add_index "activities", ["subject_type"], name: "index_activities_on_subject_type", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "avatars", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",            limit: 255
    t.boolean  "avatar_processing"
    t.string   "avatar_tmp",        limit: 255
  end

  add_index "avatars", ["user_id"], name: "index_avatars_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "creation_id"
    t.string   "text",        limit: 255
    t.integer  "disqus_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["creation_id"], name: "index_comments_on_creation_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "creations", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image",           limit: 255
    t.string   "watermark",       limit: 255
    t.integer  "photos_count",                default: 0
    t.integer  "favorites_count",             default: 0
    t.integer  "category_id"
  end

  add_index "creations", ["created_at"], name: "index_creations_on_created_at", using: :btree
  add_index "creations", ["user_id"], name: "index_creations_on_user_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0
    t.integer  "attempts",               default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "creation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["creation_id"], name: "index_favorites_on_creation_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "interests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "locatable_id"
    t.string   "locatable_type", limit: 255
    t.string   "latitude",       limit: 255
    t.string   "longitude",      limit: 255
    t.string   "city",           limit: 255
    t.string   "country",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "image",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_tmp",         limit: 255
    t.boolean  "image_processing"
    t.string   "content_type",      limit: 255
    t.string   "original_filename", limit: 255
    t.float    "latitude"
    t.float    "longitude"
    t.string   "sha256",            limit: 255
    t.string   "watermark",         limit: 255
    t.string   "imageable_type",    limit: 255
  end

  add_index "photos", ["imageable_id"], name: "index_photos_on_imageable_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  add_index "taggings", ["tagger_type"], name: "index_taggings_on_tagger_type", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "tools", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.string   "asin",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tools", ["asin"], name: "index_tools_on_asin", using: :btree
  add_index "tools", ["name"], name: "index_tools_on_name", unique: true, using: :btree

  create_table "tutorials", force: :cascade do |t|
    t.string   "heading",     limit: 255
    t.text     "description"
    t.string   "url",         limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url",   limit: 255
    t.string   "author",      limit: 255
    t.string   "author_url",  limit: 255
  end

  add_index "tutorials", ["user_id"], name: "index_tutorials_on_user_id", using: :btree

  create_table "user_sessions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "key",         limit: 255
    t.string   "ip",          limit: 255
    t.text     "user_agent"
    t.datetime "accessed_at"
    t.datetime "revoked_at"
  end

  add_index "user_sessions", ["accessed_at"], name: "index_user_sessions_on_accessed_at", using: :btree
  add_index "user_sessions", ["key"], name: "index_user_sessions_on_key", using: :btree
  add_index "user_sessions", ["revoked_at"], name: "index_user_sessions_on_revoked_at", using: :btree
  add_index "user_sessions", ["user_id"], name: "index_user_sessions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "password_digest",        limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "website",                limit: 255
    t.string   "twitter",                limit: 255
    t.string   "facebook",               limit: 255
    t.string   "city",                   limit: 255
    t.string   "authentication_token",   limit: 255
    t.string   "full_address",           limit: 255
    t.integer  "creations_count",                    default: 0
    t.boolean  "admin"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["created_at"], name: "index_users_on_created_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_interests", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "interest_id"
  end

  add_index "users_interests", ["interest_id", "user_id"], name: "index_users_interests_on_interest_id_and_user_id", using: :btree

end
