class Student < ActiveRecord::Base
	validates_presence_of :name, :email, :studentID
end
