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

ActiveRecord::Schema[7.2].define(version: 2024_10_24_160713) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "areas", force: :cascade do |t|
    t.string "area_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "park_id", null: false
    t.index ["park_id"], name: "index_areas_on_park_id"
  end

  create_table "parks", force: :cascade do |t|
    t.string "park_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "room_number", null: false
    t.string "password_digest", null: false
    t.date "date_start"
    t.date "date_end"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_number"], name: "index_rooms_on_room_number", unique: true
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "schedule_category"
    t.boolean "fix", default: false
    t.date "date_start"
    t.date "date_end"
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "time_start"
    t.time "time_end"
    t.string "content"
    t.index ["room_id"], name: "index_schedules_on_room_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shop_name"
    t.string "area"
    t.decimal "price"
    t.string "shop_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "area_id"
    t.index ["area_id"], name: "index_shops_on_area_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_number", null: false
    t.string "user_name", null: false
    t.integer "role", default: 0, null: false
  end

  create_table "users_rooms", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_users_rooms_on_room_id"
    t.index ["user_id"], name: "index_users_rooms_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "areas", "parks"
  add_foreign_key "rooms", "users"
  add_foreign_key "schedules", "rooms"
  add_foreign_key "shops", "areas"
  add_foreign_key "users_rooms", "rooms"
  add_foreign_key "users_rooms", "users"
end
