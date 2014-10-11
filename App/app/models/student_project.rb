class StudentProject < ActiveRecord::Base
	validates_presence_of :title, :summary, :image, :year, :client, :students
	has_many :students	
	mount_uploader :image, ImageUploader
	accepts_nested_attributes_for :students
end
