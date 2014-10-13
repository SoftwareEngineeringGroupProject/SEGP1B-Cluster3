class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.text :text
      t.integer :recipient_id
      t.integer :sender_id
      t.integer :project_id

      t.timestamps
    end
  end
end
