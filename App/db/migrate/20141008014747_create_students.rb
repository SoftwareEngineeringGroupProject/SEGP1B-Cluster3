class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :email
      t.string :studentID
      t.integer :phone
      t.belongs_to :group

      t.timestamps
    end
  end
end
