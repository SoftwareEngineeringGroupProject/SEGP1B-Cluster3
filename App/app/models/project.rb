class Project < ActiveRecord::Base
	has_one :attached
	belongs_to :company
	validates_presence_of :title, :body
end
