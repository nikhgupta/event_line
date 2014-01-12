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

ActiveRecord::Schema.define(version: 20140112204638) do

  create_table "channels", force: true do |t|
    t.integer  "slide_id"
    t.text     "url",        null: false
    t.text     "thumbnail"
    t.text     "caption"
    t.string   "credit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title",                             null: false
    t.text     "description"
    t.integer  "language_id",       default: 9
    t.integer  "map_type_id",       default: 4
    t.integer  "font_id",           default: 4
    t.boolean  "start_at_end",      default: false
    t.integer  "start_at_slide",    default: 0
    t.integer  "start_zoom_adjust", default: 0
    t.boolean  "hash_bookmark",     default: true
    t.boolean  "debug",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fonts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "map_types", force: true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slides", force: true do |t|
    t.integer  "event_id"
    t.string   "title",                       null: false
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "cover",       default: false
    t.string   "class_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "tags", force: true do |t|
    t.string "name"
  end

end
