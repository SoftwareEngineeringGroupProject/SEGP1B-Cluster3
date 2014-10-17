class Student < ActiveRecord::Base

     validates_presence_of :name, :email, :studentID, :course
     belongs_to :student_projects
     belongs_to :project
     validates_uniqueness_of :id
	# validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email", :multiline => true

end
