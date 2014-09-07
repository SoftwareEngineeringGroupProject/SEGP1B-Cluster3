class User < ActiveRecord::Base

	validates_length_of :username, :within => 3..40
	validates_length_of :hashed_password, :within => 5..40
	validates_presence_of :username, :email, :hashed_password, :salt
	validates_uniqueness_of :username, :email
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email", :multiline => true
  
end
