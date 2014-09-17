class StudentProject < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
