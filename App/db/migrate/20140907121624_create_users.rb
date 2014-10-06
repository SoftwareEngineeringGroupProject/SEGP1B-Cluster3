class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :acctype
      t.string :username
      t.string :hashed_password
      t.string :email
      t.string :salt
      t.string :fname
      t.string :lname
      t.string :companyname
      t.text :address
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end
