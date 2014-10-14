class ChangeDetailsToMultipleModels < ActiveRecord::Migration
  def change
  	remove_column :student_projects, :extra, :string
  	remove_column :student_projects, :group, :string
  	remove_column :students, :group_id, :string
  	add_column :student_projects, :year, :integer
  	add_column :students, :course, :string
  end
end
