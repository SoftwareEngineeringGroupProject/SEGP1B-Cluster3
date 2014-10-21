class AddCourseworksCompletedToStudents < ActiveRecord::Migration
  def change
    add_column :students, :courseworks_completed, :text
  end
end
