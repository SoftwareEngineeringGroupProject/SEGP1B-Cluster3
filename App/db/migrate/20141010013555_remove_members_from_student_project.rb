class RemoveMembersFromStudentProject < ActiveRecord::Migration
  def change
  	remove_column :student_projects, :members, :string
  end
end
