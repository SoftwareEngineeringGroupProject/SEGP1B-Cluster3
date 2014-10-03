class AddInCartToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :in_cart, :boolean
  end
end
