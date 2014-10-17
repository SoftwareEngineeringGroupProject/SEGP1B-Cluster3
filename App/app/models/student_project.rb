class StudentProject < ActiveRecord::Base
     validates_presence_of :title, :summary, :client, :category, :year
     has_many :students
     mount_uploader :image, ImageUploader
     mount_uploader :client_image, ImageUploader
     accepts_nested_attributes_for :students
     validates_uniqueness_of :id
     

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

     StudentProject.create(:title=> "QB50 SUSat CubeSat Nanosatellite Project", :client=> "QB50, The University of Adelaide",
     :summary=> "The QB50 project involves launching a network of 61 independently developed miniature satellites into
     the lower thermosphere to carry out research on the sections of the atmosphere rarely studied. The project is headed by
      the Belgian Von Karman Institute for Fluid Dynamics. SuSat is one of those satellites, which is being developed by the University
      of Adelaide and the University of South Australia.",  :image=>image_path("picture.gif"), :category=>"web application")

     StudentProject.create(:title=> "A mobile e-learning platform for Medical Students", :client=> "The Adelaide Simulation Centre",
     :summary=> "The motivation behind Respond is to ensure that medical students have the skills required to deal with emergency situations
      that will arise during their career. The Adelaide Simulation centre has students perform these kinds of scenarios but Respond is being developed
       to allow the students some time outside of the Centre to improve their skills on the iOS platform.Scenario Engine is a web-based system that helps
        users to build the medical scenarios for the Respond. Scenario Engine provide a platform for medical staff to build the scenario by filling in the medical
         data into a set of forms, which will be used to generate the scenario package and store in the system for later use.",:image=>image_path("picture.gif"),  :category=>"Mobile application")

     StudentProject.create(:title=> "Radiometri Correction of Image Sets Using Genetic Programming", :client=> " Maptek",
     :summary=> "The project aims to normalise the radiometric characteristics of sets of interrelated photos.
      Application of this project will remove the impact of changing lighting conditions during extended image capture.
     The potos are produced for Maptek by an overhead drone. After radiometric smoothing and other quality improving procedures,
     the photos are used to create a 3D model of the space, as well as large composite image. These products are extremely accurate and
     have a cariety of uses.",:image=>image_path("picture.gif"), :category=>"Mobile application")

     StudentProject.create(:title=> "Deconvolution of Aerial Photography", :client=> " Maptek",
     :summary=> "Photography taken from a moving aerial vehicle will inherently have minor amounts of blurring due to motion.
     To use the photographs in mapping, feature-matching is employed to calculate how they overlap. Even a small blue amount can
     significantly affect the results of these calculations.", :image=>image_path("picture.gif"), :category=>"Mobile application")

     StudentProject.create(:title=> "Breadcrumbs", :client=> "Airborne Research Australia",
     :summary=> "ARA uses light aircraft to perform aerial mappings. They do this by flying in parallel lines across the area.
     During these flights it's possible for spots to be missed, and this will not be known until the data is processed post-flight.
     ARA needs a tool to indicate spots that have been missed while they are in-flight.", :image=>image_url("picture.gif"), :category=>"Mobile application")

end
