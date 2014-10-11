class Student < ActiveRecord::Base
	validates_presence_of :name, :email, :studentID
	belongs_to :student_projects
end
