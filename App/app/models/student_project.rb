class StudentProject < ActiveRecord::Base
     validates_presence_of :title, :summary, :client, :category
     has_many :students
     mount_uploader :image, ImageUploader
     mount_uploader :client_image, ImageUploader
     accepts_nested_attributes_for :students, allow_destroy: true
     validates_uniqueness_of :id, :title
     

 def self.search(classify, search)
  #"title","production year", "id", "category", "summary", "client name", "studentName","studentID"]

   if classify=="title"
     where("title = ?", search)
   elsif classify=="production year"
         where("created_at = ?", search) 
            elsif classify=="id"
         where("id = ?", search) 
     elsif classify=="category" 
         where("category = ?", search)
           elsif classify=="summary" 
         where("summary = ?", search)
           elsif classify=="client name" 
         where("client = ?", search)
         else                                                                                              
     find(:all)
   end
 end

#make sure only create once
   before_create do

   end

end
