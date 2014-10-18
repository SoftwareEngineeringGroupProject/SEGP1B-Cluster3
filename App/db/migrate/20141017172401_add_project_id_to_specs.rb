class AddProjectIdToSpecs < ActiveRecord::Migration
  def change
    add_column :specs, :project_id, :integer
  end
end
