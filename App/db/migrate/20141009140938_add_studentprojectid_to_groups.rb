class AddStudentprojectidToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :student_project_id, :string
  end
end
