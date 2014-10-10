class Company < ActiveRecord::Base
	has_many :projects
	belongs_to :user
	validates_presence_of :name, :address, :website, :phone, :user_id
end
