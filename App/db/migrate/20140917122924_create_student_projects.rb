class CreateStudentProjects < ActiveRecord::Migration
  def change
    create_table :student_projects do |t|

      t.timestamps
    end
  end
end
