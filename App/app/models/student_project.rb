class StudentProject < ActiveRecord::Base
	validates_presence_of :title, :group, :summary, :extra, :image
	has_one :group	
	mount_uploader :image, ImageUploader
	accepts_nested_attributes_for :group
end
