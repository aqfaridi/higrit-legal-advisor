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

ActiveRecord::Schema.define(version: 20160114203307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comment_hierarchies", force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.boolean  "flag"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "parent_id"
  end

  create_table "postags", id: false, force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.integer  "user_id"
    t.datetime "closed_at"
    t.boolean  "flag"
    t.integer  "cat_id"
    t.datetime "published_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "posts", ["id"], name: "index_posts_on_id", unique: true, using: :btree
  add_index "posts", ["published_at"], name: "index_posts_on_published_at", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.integer  "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",             limit: 32,                         null: false
    t.string   "mobile",           limit: 10,                         null: false
    t.string   "email",                                               null: false
    t.string   "salt"
    t.string   "password",                                            null: false
    t.string   "gender",                                              null: false
    t.string   "dob"
    t.string   "imagename",                   default: "default.jpg"
    t.text     "about"
    t.string   "ckey"
    t.string   "ctime"
    t.string   "mobileflag",                  default: "0"
    t.string   "emailflag",                   default: "0"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "total_view_count",            default: 0
  end

  create_table "views", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "total_view_count", default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "votecoms", force: :cascade do |t|
    t.integer  "com_id"
    t.integer  "user_id"
    t.integer  "vote_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "voteposts", force: :cascade do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "vote_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votetypes", force: :cascade do |t|
    t.integer  "upvote",     default: 1
    t.integer  "downvote",   default: -1
    t.integer  "ac",         default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
