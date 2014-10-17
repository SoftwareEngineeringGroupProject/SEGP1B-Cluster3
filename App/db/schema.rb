# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141017005926) do

  create_table "attacheds", force: true do |t|
    t.integer  "project_id"
    t.binary   "attached"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: true do |t|
    t.integer  "project_id"
    t.binary   "attached"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filename"
    t.string   "content_type"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "address"
    t.string   "phone"
    t.string   "reference_code"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "messages", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "company_id"
    t.integer  "attched_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "in_cart"
    t.integer  "attachment_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "user_id"
  end

  create_table "student_projects", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "summary"
    t.string   "image"
    t.integer  "year"
    t.string   "client"
    t.string   "client_image"
    t.string   "category"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "studentID"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "course"
    t.integer  "student_project_id"
  end

  create_table "users", force: true do |t|
    t.string   "acctype"
    t.string   "username"
    t.string   "hashed_password"
    t.string   "email"
    t.string   "salt"
    t.string   "fname"
    t.string   "lname"
    t.string   "companyname"
    t.text     "address"
    t.string   "phone"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "passwordvalid"
  end

end
