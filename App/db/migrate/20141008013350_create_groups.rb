class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :groupID
      t.integer :numOfMembers
      t.belongs_to :StudentProject

      t.timestamps
    end
  end
end
