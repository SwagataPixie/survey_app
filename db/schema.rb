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

ActiveRecord::Schema.define(version: 20170408050529) do

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "answer_times", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "time"
    t.integer  "survey_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_answer_times_on_question_id", using: :btree
    t.index ["survey_id"], name: "index_answer_times_on_survey_id", using: :btree
  end

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "comment"
    t.integer  "choice_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.integer  "survey_id"
    t.index ["choice_id"], name: "index_answers_on_choice_id", using: :btree
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
    t.index ["survey_id"], name: "index_answers_on_survey_id", using: :btree
  end

  create_table "choices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "content"
    t.boolean  "correct"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_choices_on_question_id", using: :btree
  end

  create_table "question_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "statement",        limit: 65535
    t.integer  "question_type_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["question_type_id"], name: "index_questions_on_question_type_id", using: :btree
  end

  create_table "questions_surveys", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "question_id"
    t.integer "survey_id"
    t.index ["question_id"], name: "index_questions_surveys_on_question_id", using: :btree
    t.index ["survey_id"], name: "index_questions_surveys_on_survey_id", using: :btree
  end

  create_table "questions_tags", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "question_id"
    t.integer "tag_id"
    t.index ["question_id"], name: "index_questions_tags_on_question_id", using: :btree
    t.index ["tag_id"], name: "index_questions_tags_on_tag_id", using: :btree
  end

  create_table "surveys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "number_of_question"
    t.integer  "pass_marks"
    t.integer  "score"
    t.datetime "taken_on"
    t.datetime "valid_from"
    t.datetime "valid_till"
    t.string   "remaining_time"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "tag_id"
    t.index ["tag_id"], name: "index_surveys_on_tag_id", using: :btree
    t.index ["user_id"], name: "index_surveys_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
