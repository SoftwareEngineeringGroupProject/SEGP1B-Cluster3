class AddConceptsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :concepts, :text
  end
end
