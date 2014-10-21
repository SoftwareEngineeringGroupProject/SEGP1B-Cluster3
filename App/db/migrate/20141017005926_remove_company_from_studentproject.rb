class RemoveCompanyFromStudentproject < ActiveRecord::Migration
  def change
  	remove_column :student_projects, :company, :string
  end
end
