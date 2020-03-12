# frozen_string_literal: true

ActiveRecord::Schema.define(version: 2019_06_13_171437) do
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
    t.index %w[team_id exploit_id], name: "index_exploits_teams_on_team_id_and_exploit_id", unique: true
  end

  create_table "flags", force: :cascade do |t|
    t.string "content", null: false
    t.bigint "team_id"
    t.bigint "exploit_id"
    t.integer "status", default: 0, null: false
    t.float "pts", default: 0.0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
