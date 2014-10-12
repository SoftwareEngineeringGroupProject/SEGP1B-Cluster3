class AddAttachmentIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :attachment_id, :integer
  end
end
