class Pastprojects < ActiveRecord::Migration
  def up
    create_table :pastprojects do |t|
            t.string :title, :limit => 50, :null => false
           t.string :pastproject_id                                    #added by symtem itself
          t.string :category, :limit => 50, :null => false
          t.string  :banner, :limit => 50
          t.date :year, :null => false
          t.string :company_id, :limit => 50, :null => false
          t.string :company_name, :limit => 50, :null => false
           t.text :synopsis,  :null => false
           t.text :feedback
           t.binary :project_image       
    end
    
    #a students table that will be used in pastproject Memember lists
    create_table :pastprojects_students do |t|
         t.belongs_to :pastproject
         t.string :student_name
         t.string :student_id
         t.string :email
         t.string :phone
           t.string :degree
    end
    
  end

  def down
    drop_table :pastprojects
    drop_table :pastprojects_students
  end
end
