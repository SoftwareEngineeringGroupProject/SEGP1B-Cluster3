class AddClientToStudentProjects < ActiveRecord::Migration
  def change
    add_column :student_projects, :client, :string
  end
end
