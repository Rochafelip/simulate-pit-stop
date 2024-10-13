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

ActiveRecord::Schema[7.1].define(version: 2024_09_09_181032) do
  create_table "cars", force: :cascade do |t|
    t.string "model"
    t.integer "power"
    t.integer "weight"
    t.float "fuel_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  create_table "races", force: :cascade do |t|
    t.integer "track_id", null: false
    t.integer "car_id", null: false
    t.float "average_lap_time"
    t.float "fuel_consumption_per_lap"
    t.integer "total_laps"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_races_on_car_id"
    t.index ["track_id"], name: "index_races_on_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.float "distance"
    t.integer "number_of_curves"
    t.string "country"
    t.float "elevation_track"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "races", "cars"
  add_foreign_key "races", "tracks"
end
