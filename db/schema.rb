# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_06_034910) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "circunscriptions", force: :cascade do |t|
    t.bigint "municipality_id", null: false
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id"
    t.bigint "sync_excel_id"
    t.index ["municipality_id"], name: "index_circunscriptions_on_municipality_id"
    t.index ["provider_id"], name: "index_circunscriptions_on_provider_id"
    t.index ["sync_excel_id"], name: "index_circunscriptions_on_sync_excel_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id"
    t.bigint "sync_excel_id"
    t.index ["provider_id", "sync_excel_id", "name"], name: "index_countries_on_provider_id_and_sync_excel_id_and_name", unique: true
    t.index ["provider_id"], name: "index_countries_on_provider_id"
    t.index ["sync_excel_id"], name: "index_countries_on_sync_excel_id"
  end

  create_table "denormalize_data", force: :cascade do |t|
    t.integer "table_code"
    t.string "type_of_vote"
    t.string "country"
    t.string "state"
    t.integer "circumscription"
    t.string "province"
    t.string "municipality"
    t.string "location"
    t.string "precinct"
    t.integer "table_number"
    t.integer "total_enrollments"
    t.integer "c"
    t.integer "adn"
    t.integer "mas_ipsp"
    t.integer "fpv"
    t.integer "pan_bol"
    t.integer "libre_21"
    t.integer "cc"
    t.integer "juntos"
    t.integer "valid_votes"
    t.integer "blank_votes"
    t.integer "null_votes"
    t.integer "emit_vote"
    t.integer "valid_system_vote"
    t.integer "emit_system_vote"
    t.bigint "provider_id", null: false
    t.bigint "sync_excel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider_id"], name: "index_denormalize_data_on_provider_id"
    t.index ["sync_excel_id"], name: "index_denormalize_data_on_sync_excel_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "circunscription_id"
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id"
    t.bigint "sync_excel_id"
    t.index ["circunscription_id"], name: "index_locations_on_circunscription_id"
    t.index ["provider_id"], name: "index_locations_on_provider_id"
    t.index ["sync_excel_id"], name: "index_locations_on_sync_excel_id"
  end

  create_table "municipalities", force: :cascade do |t|
    t.bigint "province_id", null: false
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "provider_id"
    t.bigint "sync_excel_id"
    t.index ["provider_id"], name: "index_municipalities_on_provider_id"
    t.index ["province_id"], name: "index_municipalities_on_province_id"
    t.index ["sync_excel_id"], name: "index_municipalities_on_sync_excel_id"
  end

  create_table "politic_parties", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "precincts", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id"
    t.bigint "sync_excel_id"
    t.index ["location_id"], name: "index_precincts_on_location_id"
    t.index ["provider_id"], name: "index_precincts_on_provider_id"
    t.index ["sync_excel_id"], name: "index_precincts_on_sync_excel_id"
  end

  create_table "providers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id"
    t.bigint "sync_excel_id"
    t.index ["provider_id"], name: "index_provinces_on_provider_id"
    t.index ["state_id"], name: "index_provinces_on_state_id"
    t.index ["sync_excel_id"], name: "index_provinces_on_sync_excel_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id"
    t.bigint "sync_excel_id"
    t.index ["country_id", "provider_id", "sync_excel_id", "name"], name: "states_country_name", unique: true
    t.index ["country_id"], name: "index_states_on_country_id"
    t.index ["provider_id"], name: "index_states_on_provider_id"
    t.index ["sync_excel_id"], name: "index_states_on_sync_excel_id"
  end

  create_table "sync_excels", force: :cascade do |t|
    t.string "folder_name"
    t.datetime "sync_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id", null: false
    t.index ["provider_id"], name: "index_sync_excels_on_provider_id"
  end

  create_table "type_of_elections", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "voting_table_id", null: false
    t.bigint "politic_party_id", null: false
    t.bigint "type_of_election_id", null: false
    t.integer "total_votes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "provider_id"
    t.bigint "sync_excel_id"
    t.index ["politic_party_id"], name: "index_votes_on_politic_party_id"
    t.index ["provider_id"], name: "index_votes_on_provider_id"
    t.index ["sync_excel_id"], name: "index_votes_on_sync_excel_id"
    t.index ["type_of_election_id"], name: "index_votes_on_type_of_election_id"
    t.index ["voting_table_id"], name: "index_votes_on_voting_table_id"
  end

  create_table "voting_tables", force: :cascade do |t|
    t.bigint "precinct_id", null: false
    t.string "table_number"
    t.string "table_code"
    t.integer "total_enrollments"
    t.integer "valid_votes"
    t.integer "blank_votes"
    t.integer "null_votes"
    t.string "act_state"
    t.datetime "catch_date"
    t.bigint "provider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "sync_excel_id"
    t.index ["precinct_id"], name: "index_voting_tables_on_precinct_id"
    t.index ["provider_id"], name: "index_voting_tables_on_provider_id"
    t.index ["sync_excel_id"], name: "index_voting_tables_on_sync_excel_id"
  end

  add_foreign_key "circunscriptions", "municipalities"
  add_foreign_key "circunscriptions", "providers"
  add_foreign_key "circunscriptions", "sync_excels"
  add_foreign_key "countries", "providers"
  add_foreign_key "countries", "sync_excels"
  add_foreign_key "denormalize_data", "providers"
  add_foreign_key "denormalize_data", "sync_excels"
  add_foreign_key "locations", "circunscriptions"
  add_foreign_key "locations", "providers"
  add_foreign_key "locations", "sync_excels"
  add_foreign_key "municipalities", "providers"
  add_foreign_key "municipalities", "provinces"
  add_foreign_key "municipalities", "sync_excels"
  add_foreign_key "precincts", "locations"
  add_foreign_key "precincts", "providers"
  add_foreign_key "precincts", "sync_excels"
  add_foreign_key "provinces", "providers"
  add_foreign_key "provinces", "states"
  add_foreign_key "provinces", "sync_excels"
  add_foreign_key "states", "countries"
  add_foreign_key "states", "providers"
  add_foreign_key "states", "sync_excels"
  add_foreign_key "sync_excels", "providers"
  add_foreign_key "votes", "politic_parties"
  add_foreign_key "votes", "providers"
  add_foreign_key "votes", "sync_excels"
  add_foreign_key "votes", "type_of_elections"
  add_foreign_key "votes", "voting_tables"
  add_foreign_key "voting_tables", "precincts"
  add_foreign_key "voting_tables", "providers"
  add_foreign_key "voting_tables", "sync_excels"
end
