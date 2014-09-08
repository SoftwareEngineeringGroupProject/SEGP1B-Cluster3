class CreateStudentProjects < ActiveRecord::Migration
  def change
    create_table :student_projects do |t|
      t.string :title
      t.string :summary
      t.string :group_name
      t.string :members

      t.timestamps
    end
  end
end
