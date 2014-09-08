class RemoveProjectFromAttacheds < ActiveRecord::Migration
 def change
   remove_column :attacheds, :project, :integer
 end
end
