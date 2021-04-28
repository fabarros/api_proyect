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

ActiveRecord::Schema.define(version: 2021_04_28_055716) do

  create_table "albums", id: false, force: :cascade do |t|
    t.string "id"
    t.string "name"
    t.string "genre"
    t.string "artist_id"
    t.string "artist"
    t.string "tracks"
    t.string "self"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "artists", id: false, force: :cascade do |t|
    t.string "id"
    t.string "name"
    t.integer "age"
    t.string "albums"
    t.string "tracks"
    t.string "self"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tracks", id: false, force: :cascade do |t|
    t.string "id"
    t.string "name"
    t.float "duration"
    t.integer "times_played"
    t.string "artist_id"
    t.string "album_id"
    t.string "artist"
    t.string "album"
    t.string "self"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
