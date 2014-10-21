class AddIsNewToStudents < ActiveRecord::Migration
  def change
    add_column :students, :is_new, :boolean
  end
end
