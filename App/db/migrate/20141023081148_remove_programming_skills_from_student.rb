class RemoveProgrammingSkillsFromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :programming_skils, :text
  end
end
