class StudentProject < ActiveRecord::Base
     validates_presence_of :title, :summary, :client, :category
     has_many :students
     mount_uploader :image, ImageUploader
     mount_uploader :client_image, ImageUploader
     accepts_nested_attributes_for :students, allow_destroy: true
     validates_uniqueness_of :id, :title
     
#the search funtion used in search bar of index page
 def self.search(classify, search, dateChoose)
  #"title","production year", "id", "category", "summary", "client name", "studentName","studentID"]
   
   #find project by related attributes here
   if classify.downcase=="title"
     where("title = ? and strftime('%Y', created_at) = ?", search,dateChoose )
     elsif classify.downcase=="id"
            where("id = ? and strftime('%Y', created_at) = ?", search,dateChoose) 
     elsif classify.downcase=="category" 
             where("category = ? and strftime('%Y', created_at) = ?", search,dateChoose)
         elsif classify.downcase=="client name" 
             where("client = ? and strftime('%Y', created_at) = ?", search,dateChoose)
         elsif search =="" 
            #output results with selected year if input empty                                                                                                                                                                                                     
              where("strftime('%Y', created_at) = ?", dateChoose)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
   end
 end

#make sure only create once
   before_create do

   end

end
