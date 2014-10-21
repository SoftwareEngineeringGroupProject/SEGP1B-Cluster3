class ProjectExtraFields < ActiveRecord::Migration
  def change
  	add_column :projects, :compl_time, :integer
  	add_column :projects, :man_hours, :string
  	add_column :projects, :languages, :text
  	add_column :projects, :system_req, :text
  	add_column :projects, :compat_req, :text
  	add_column :projects, :student_req_lang, :text
  	add_column :projects, :student_req_concepts, :text
  	add_column :projects, :student_police_check, :string
  	add_column :projects, :student_security, :text
  	add_column :projects, :extra_details, :text
  end
end
