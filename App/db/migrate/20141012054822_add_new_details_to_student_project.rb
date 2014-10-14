class AddNewDetailsToStudentProject < ActiveRecord::Migration
  def change
    add_column :student_projects, :client_image, :string
    add_column :student_projects, :category, :string
  end
end
