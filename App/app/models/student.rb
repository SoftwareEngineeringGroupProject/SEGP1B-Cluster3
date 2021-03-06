class Student < ActiveRecord::Base

     validates_presence_of :name, :email, :studentID, :course
     belongs_to :student_project
     validates_uniqueness_of :id, :name, :email, :studentID
     accepts_nested_attributes_for :student_project, allow_destroy: true
          
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => ": Invalid email", :multiline => true
	validates_format_of :name, :with => /[a-z]/, :message => ": Name cannot contain numbers", :multiline => true


end
