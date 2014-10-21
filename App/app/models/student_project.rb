class StudentProject < ActiveRecord::Base
	validates_presence_of :title, :summary, :client, :category, :year
	has_many :students
	mount_uploader :image, ImageUploader
	mount_uploader :client_image, ImageUploader
	accepts_nested_attributes_for :students, allow_destroy: true
	validates_uniqueness_of :id, :title
	#the search funtion used in search bar of index page
	def self.search(classify, search)
		#"title","production year", "id", "category", "summary", "client name", "studentName","studentID"]

		#find project by related attributes here
		if classify.downcase=="title"
			where("title like ?", "%#{search}%" )
		elsif classify.downcase=="id"
			where("id = ?", search)
		elsif classify.downcase=="category"
			where("category like ?", "%#{search}%" )
		elsif classify.downcase=="client name"
			where("client like ?", "%#{search}%" )
		elsif classify.downcase=="year"
			where("year = ?", search.to_i)
		#vague search else
		else
			#make sure only serach string(size>=3) can be used in vague search
			if search.empty? ==false && search.length>=3
				where("title like ? or id = ? or category like ? or client like ? or year = ?", "%#{search}%", search, "%#{search}%", "%#{search}%", search.to_i)
			end
		end
	end

	#make sure only create once
	before_create do
	end

end
