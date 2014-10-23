class RemoveDetailsFromStudent < ActiveRecord::Migration
  def change
  	remove_column :students, :is_new, :boolean
  	remove_column :students, :programming_skills, :text
  	remove_column :students, :courseworks_completed, :text
  	remove_column :students, :concepts, :text
  	remove_column :students, :GPA, :string
  	remove_column :students, :project_id, :integer
  end
end
