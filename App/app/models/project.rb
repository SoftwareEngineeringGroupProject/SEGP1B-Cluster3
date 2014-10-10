class Project < ActiveRecord::Base
	has_one :attached
	has_many :messages
	belongs_to :company
	validates_presence_of :title, :body
end
