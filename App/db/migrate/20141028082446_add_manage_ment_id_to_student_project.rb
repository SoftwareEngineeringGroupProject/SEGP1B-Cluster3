class AddManageMentIdToStudentProject < ActiveRecord::Migration
  def change
    add_column :student_projects, :pastproject_management_id, :integer
  end
end
