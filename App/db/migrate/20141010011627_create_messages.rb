class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.string :author
      t.string :recipient

      t.timestamps
    end
  end
end
