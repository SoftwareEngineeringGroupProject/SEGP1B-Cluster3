class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
    Admin.create(username: "admin", password: "1234")

  end
end
