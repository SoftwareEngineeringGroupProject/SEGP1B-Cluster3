class RemoveGroupIDfromGroups < ActiveRecord::Migration
  def change
  	remove_column :groups, :groupID, :string
  end
end
