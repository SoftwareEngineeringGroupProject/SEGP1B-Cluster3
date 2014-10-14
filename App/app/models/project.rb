class Project < ActiveRecord::Base
	has_one :attachment
	has_many :messages
	belongs_to :user
	has_attached_file :attachment
	validates_presence_of :title, :body
	

	validates_attachment_content_type :attachment, :content_type => ["application/pdf","application/vnd.ms-excel",
					"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
					"application/msword",
					"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
					"text/plain"],:message => "Acceptable types: PDF, EXCEL, WORD or TEXT files."
	validates_attachment_size :attachment, :less_than => 5.megabytes, :message => "File cannot exceeeds 5megabytes"
end
