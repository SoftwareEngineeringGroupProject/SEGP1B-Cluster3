class CreatePastprojectManagements < ActiveRecord::Migration
  def change
    create_table :pastproject_managements do |t|

      t.timestamps
    end
  end
end
