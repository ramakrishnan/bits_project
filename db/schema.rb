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

ActiveRecord::Schema.define(:version => 20120302072115) do

  create_table "collections", :force => true do |t|
    t.string   "type"
    t.text     "data"
    t.integer  "widget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grids", :force => true do |t|
    t.string   "name"
    t.integer  "width"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holdings", :force => true do |t|
    t.integer  "widget_id"
    t.integer  "placeholder_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.boolean  "is_live"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "placeholders", :force => true do |t|
    t.integer  "page_id"
    t.integer  "grid_id"
    t.integer  "row"
    t.integer  "column"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "name"
    t.string   "thumbnail"
    t.string   "embed_src"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "widget_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "widgets", :force => true do |t|
    t.string   "name"
    t.string   "filename"
    t.integer  "width"
    t.integer  "widget_type"
    t.text     "style"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
