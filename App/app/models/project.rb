class Project < ActiveRecord::Base
	has_one :attachment
	belongs_to :company
	has_attached_file :attachment
	validates_presence_of :title, :body

	validates_attachment_content_type :attachment, :content_type => ["application/pdf","application/vnd.ms-excel",
					"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
					"application/msword",
					"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
					"text/plain"], :size => { :in => 0..5.megabytes }, :message => "Acceptable types: PDF, EXCEL, WORD or TEXT files. Size-max:5mB"
end
