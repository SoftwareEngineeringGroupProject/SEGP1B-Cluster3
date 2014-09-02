class CreateAttacheds < ActiveRecord::Migration
  def change
    create_table :attacheds do |t|
      t.integer :project_id
      t.binary :attached

      t.timestamps
    end
  end
end
