class AddProjectIdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :project_id, :integer
  end
end
