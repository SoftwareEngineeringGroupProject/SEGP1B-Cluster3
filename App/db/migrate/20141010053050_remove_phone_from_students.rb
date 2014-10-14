class RemovePhoneFromStudents < ActiveRecord::Migration
  def change
  	remove_column :students, :phone, :integer
  end
end
