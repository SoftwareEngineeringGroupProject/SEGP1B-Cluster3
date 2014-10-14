class AddPasswordValidToUsers < ActiveRecord::Migration
  def change
  		add_column :users, :passwordvalid, :integer
  end
end
