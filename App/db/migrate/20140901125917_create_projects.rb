class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :body
      t.integer :company_id
      t.integer :attched_id
      t.string :status

      t.timestamps
    end
  end
end
