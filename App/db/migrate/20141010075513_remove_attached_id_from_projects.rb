class RemoveAttachedIdFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :attached_id, :integer
  end
end
