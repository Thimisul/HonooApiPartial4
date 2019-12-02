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

ActiveRecord::Schema.define(version: 2019_11_24_230221) do

  create_table "event_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.datetime "startDate"
    t.datetime "endDate"
    t.string "street"
    t.string "neighborhood"
    t.string "city"
    t.string "referencePoint"
    t.string "description"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "ownerId"
    t.bigint "eventTypeId"
    t.index ["eventTypeId"], name: "fk_rails_c382144af1"
    t.index ["ownerId"], name: "fk_rails_a58f2a17cf"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "date"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "participantId"
    t.index ["participantId"], name: "fk_rails_941f50a762"
  end

  create_table "msgs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "message"
    t.datetime "date"
    t.bigint "participantId"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participantId"], name: "fk_rails_0a6a1c2d7c"
  end

  create_table "participants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "registrationDate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "userId"
    t.bigint "eventoId"
    t.index ["eventoId"], name: "fk_rails_767a7af066"
    t.index ["userId"], name: "fk_rails_bddc25f6d4"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password"
    t.datetime "birthdate"
    t.string "sex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true
  end

  add_foreign_key "events", "event_types", column: "eventTypeId"
  add_foreign_key "events", "users", column: "ownerId"
  add_foreign_key "messages", "participants", column: "participantId"
  add_foreign_key "msgs", "participants", column: "participantId"
  add_foreign_key "participants", "events", column: "eventoId"
  add_foreign_key "participants", "users", column: "userId"
end
