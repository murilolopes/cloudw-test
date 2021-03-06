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

ActiveRecord::Schema.define(version: 2021_12_15_010325) do

  create_table "deaths", force: :cascade do |t|
    t.integer "game_id"
    t.string "cause"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "assassin_id"
    t.integer "victim_id"
    t.index ["assassin_id"], name: "index_deaths_on_assassin_id"
    t.index ["game_id"], name: "index_deaths_on_game_id"
    t.index ["victim_id"], name: "index_deaths_on_victim_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "game_id"
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  add_foreign_key "deaths", "players", column: "assassin_id"
  add_foreign_key "deaths", "players", column: "victim_id"
end
