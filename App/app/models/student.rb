class Student < ActiveRecord::Base

     validates_presence_of :name, :email, :studentID, :course
     belongs_to :studentproject
     validates_uniqueness_of :id, :name, :email, :studentID
     accepts_nested_attributes_for :studentproject, allow_destroy: true
          
# validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email", :multiline => true

end
