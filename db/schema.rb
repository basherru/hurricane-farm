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

ActiveRecord::Schema.define(version: 2019_06_03_163735) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exploits", force: :cascade do |t|
    t.string "source", null: false
    t.integer "period", default: 30, null: false
    t.integer "timeout", default: 30, null: false
    t.string "state", default: "initial", null: false
    t.string "title", default: "unnamed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "flags", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "team_id"
    t.bigint "exploit_id"
    t.string "status", default: "initial", null: false
    t.float "pts", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exploit_id"], name: "index_flags_on_exploit_id"
    t.index ["pts"], name: "index_flags_on_pts"
    t.index ["status"], name: "index_flags_on_status"
    t.index ["team_id"], name: "index_flags_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "title", default: "unnamed", null: false
    t.string "ip", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
