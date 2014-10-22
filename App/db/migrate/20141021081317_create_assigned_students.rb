class CreateAssignedStudents < ActiveRecord::Migration
  def change
    create_table :assigned_students do |t|
      t.string :studentID
      t.integer :project_id

      t.timestamps
    end
  end
end
