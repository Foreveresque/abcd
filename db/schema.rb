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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120511203139) do

  create_table "pojams", :force => true do |t|
    t.string   "izraz"
    t.string   "tip"
    t.string   "znacenje"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pojams_pojams", :id => false, :force => true do |t|
    t.integer "id1"
    t.integer "id2"
  end

  create_table "replays", :force => true do |t|
    t.string   "dire"
    t.string   "radiant"
    t.date     "time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "termlinks", :force => true do |t|
    t.integer  "term_id"
    t.integer  "link_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "terms", :force => true do |t|
    t.string   "word"
    t.string   "type"
    t.string   "meaning"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end