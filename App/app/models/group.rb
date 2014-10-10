class Group < ActiveRecord::Base
	belongs_to :StudentProject
	has_many :students
	validates_presence_of :name, :numOfMembers
end
