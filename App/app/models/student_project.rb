class StudentProject < ActiveRecord::Base
	validates_presence_of :title, :group, :summary, :members, :extra, :image
	mount_uploader :image, ImageUploader
end
