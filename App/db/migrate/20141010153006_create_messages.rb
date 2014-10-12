class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :text
      t.integer :project_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
