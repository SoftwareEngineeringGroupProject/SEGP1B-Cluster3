class AddGroupNameToAssignedStudents < ActiveRecord::Migration
  def change
    add_column :assigned_students, :group_name, :string
  end
end
