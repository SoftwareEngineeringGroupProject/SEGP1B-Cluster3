class AddProjectIdToAttacheds < ActiveRecord::Migration
  def change
    add_column :attacheds, :project_id, :integer
  end
end
