class AddStudentprojectsidToStudents < ActiveRecord::Migration
  def change
    add_column :students, :student_project_id, :integer
  end
end
