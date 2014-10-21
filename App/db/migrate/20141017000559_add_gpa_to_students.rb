class AddGpaToStudents < ActiveRecord::Migration
  def change
    add_column :students, :GPA, :string
  end
end
