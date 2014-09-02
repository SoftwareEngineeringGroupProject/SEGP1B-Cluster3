class Company < ActiveRecord::Base
	has_many :projects
	validates_presence_of :name, :address, :website, :phone, :email
end
