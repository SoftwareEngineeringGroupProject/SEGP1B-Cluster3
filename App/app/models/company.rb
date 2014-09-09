class Company < ActiveRecord::Base
	has_many :projects
	validates_presence_of :name, :address, :website, :phone, :email
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email", :multiline => true
end
