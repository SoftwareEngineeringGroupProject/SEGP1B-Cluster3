class Message < ActiveRecord::Base
	
	belongs_to :project
	validates_presence_of :subject, :body

	
end
