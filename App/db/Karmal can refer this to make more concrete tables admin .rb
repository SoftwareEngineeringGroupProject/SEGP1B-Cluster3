class CreateAdmins < ActiveRecord::Migration
    def up
        create_table :admins do |t|
            t.string :username, :limit => 50, :null => false
            t.string :password, :limit => 50, :null => false
            t.string :email, :limit => 50
            t.timestamp :LastAccessTime     #generate by system
        end

    end

    def down
        drop_table :admins
    end
end