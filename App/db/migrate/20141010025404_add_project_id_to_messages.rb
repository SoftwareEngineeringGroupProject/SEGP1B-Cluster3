class AddProjectIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :project_id, :integer
  end
end
