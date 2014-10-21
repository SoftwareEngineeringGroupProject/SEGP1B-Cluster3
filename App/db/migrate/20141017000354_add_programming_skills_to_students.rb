class AddProgrammingSkillsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :programming_skils, :text
  end
end
