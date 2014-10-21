class AddAuthTokenToSpecs < ActiveRecord::Migration
  def change
    add_column :specs, :auth_token, :string
  end
end
