# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_26_133402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exploits", force: :cascade do |t|
    t.string "source", null: false
    t.integer "period", default: 30, null: false
    t.integer "timeout", default: 30, null: false
    t.integer "status", default: 0, null: false
    t.string "title", default: "Unknown", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "scheduler_handle"
  end

  create_table "exploits_teams", id: false, force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "exploit_id", null: false
    t.index ["team_id", "exploit_id"], name: "index_exploits_teams_on_team_id_and_exploit_id", unique: true
  end

  create_table "flags", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "team_id"
    t.bigint "exploit_id"
    t.integer "status", default: 0, null: false
    t.float "pts", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_flags_on_content", unique: true
    t.index ["exploit_id"], name: "index_flags_on_exploit_id"
    t.index ["pts"], name: "index_flags_on_pts"
    t.index ["status"], name: "index_flags_on_status"
    t.index ["team_id"], name: "index_flags_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "title", default: "Unknown", null: false
    t.string "host", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
