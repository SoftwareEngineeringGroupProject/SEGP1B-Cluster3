class Student < ActiveRecord::Base
	belongs_to :group
	validates_presence_of :name, :email, :studentID, :phone
end