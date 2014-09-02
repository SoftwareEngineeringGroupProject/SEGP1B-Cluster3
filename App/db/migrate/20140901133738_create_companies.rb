class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :username
      t.string :address
      t.string :phone
      t.string :reference_code
      t.string :email
      t.string :website

      t.timestamps
    end
  end
end
