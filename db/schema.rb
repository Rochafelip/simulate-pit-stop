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

ActiveRecord::Schema[7.1].define(version: 2024_07_26_182336) do
  create_table "cars", force: :cascade do |t|
    t.string "model", null: false
    t.integer "power", null: false
    t.integer "weight", null: false
    t.float "fuel_capacity", null: false
    t.float "fuel_consumption_per_lap", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name", null: false
    t.float "length", null: false
    t.integer "number_of_curves", null: false
    t.float "car_lap_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
