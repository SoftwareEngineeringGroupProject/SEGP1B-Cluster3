class AddDetailsToStudentProject < ActiveRecord::Migration
  def change
    add_column :student_projects, :title, :string
    add_column :student_projects, :group, :string
    add_column :student_projects, :members, :string
    add_column :student_projects, :summary, :string
    add_column :student_projects, :extra, :string
    add_column :student_projects, :image, :string
  end
end
