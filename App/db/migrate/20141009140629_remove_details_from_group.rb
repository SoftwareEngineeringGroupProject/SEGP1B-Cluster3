class RemoveDetailsFromGroup < ActiveRecord::Migration
  def change
    remove_column :groups, :StudentProject, :string
  end
end
