class Student < ActiveRecord::Base
	validates_presence_of :name, :email, :studentID, :course
	# validates_presence_of :name, :email
	belongs_to :student_projects
	# named_scope :unique_by_course, :select => 'DISTINCT course', :order => 'course ASC'
end
