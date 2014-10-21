# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")
 
 #a image seed function used to insert images
def seed_image(file_name)
       File.open(File.join(Rails.root, "/public/images/seed/#{file_name}"))
end

User.create(username: "industry", email: "industry@indust.com", password: "cluster3", password_confirmation: "cluster3", fname: "Default", lname: "User", companyname: "Cluster 3", address: "NA", phone: "NA", website: "NA", acctype: "industry")
User.create(username: "administrator", email: "admin@admin.com", password: "cluster3", password_confirmation: "cluster3", fname: "Default", lname: "Admin", companyname: "Cluster 3", address: "NA", phone: "NA", website: "NA", acctype: "coordinator")

     StudentProject.create(:title=> "QB50 SUSat CubeSat Nanosatellite Project", :client=> "QB50, The University of Adelaide",
     :summary=> "The QB50 project involves launching a network of 61 independently developed miniature satellites into
     the lower thermosphere to carry out research on the sections of the atmosphere rarely studied. The project is headed by
      the Belgian Von Karman Institute for Fluid Dynamics. SuSat is one of those satellites, which is being developed by the University
      of Adelaide and the University of South Australia.", :image=>seed_image("p1.jpeg"), :client_image=>seed_image("p2.jpeg"), :category=>"web application", 
     :students_attributes=>[{:name=>"Scott Lamacraft", :email=>"a1607969@student.adelaide.edu.au", :studentID=>"a1607969", :course=>"BEng(Software)"}, 
{:name=>"Sergei Fadeev", :email=>" a1608693@student.adelaide.edu.au", :studentID=>" a1608693", :course=>"BEng(Software)"},
{:name=>"Samuel Wong", :email=>" a1607031@student.adelaide.edu.au", :studentID=>" a1607031", :course=>"BEng(Software)"}], 
:year=>2014, :client_summary=> "Maptek™ is the leading provider of innovative software, hardware and services for the global mining industry. With more than 30 years of commitment to mine technology research and development,
 we offer an extensive range of products backed by unparalleled customer service and support.", :client_link=>"http://www.maptek.com/")

     StudentProject.create(:title=> "A mobile e-learning platform for Medical Students", :client=> "The Adelaide Simulation Centre",
     :summary=> "The motivation behind Respond is to ensure that medical students have the skills required to deal with emergency situations
      that will arise during their career. The Adelaide Simulation centre has students perform these kinds of scenarios but Respond is being developed
       to allow the students some time outside of the Centre to improve their skills on the iOS platform.Scenario Engine is a web-based system that helps
        users to build the medical scenarios for the Respond. Scenario Engine provide a platform for medical staff to build the scenario by filling in the medical
         data into a set of forms, which will be used to generate the scenario package and store in the system for later use.",:image=>seed_image("p1.jpeg"), 
         :client_image=>seed_image("p2.jpeg"),  :category=>"Mobile application", 
         :students_attributes=>[{:name=>"Scott", :email=>"a1607969@student.adelaide.edu.au", :studentID=>"a160", :course=>"BEng(Software)"}, 
{:name=>"Sergei", :email=>" a163@student.adelaide.edu.au", :studentID=>" a1603", :course=>"BEng(Software)"},
{:name=>"Samuel", :email=>" a1631@student.adelaide.edu.au", :studentID=>" a1631", :course=>"BEng(Software)"}], 
:year=>2011, :client_summary=>"One of the most high-tech medical teaching facilities in South Australia, the Adelaide Health Simulation & Skills Centre, 
has been developed to address current and future inter-professional learning needs of health and related workforces. Equipped with a variety of simulation manikins 
and a fully integrated audiovisual system for remote video conferencing, the Centre offers the capacity for all levels of fidelity in simulation education as well as training.
Using state-of-the-art technology to deliver an innovative and effective learning experience, our safe, evidence-based environment supports participants to develop 
clinical and interpersonal skills as well as the confidence and competence to work effectively within their healthcare teams.", :client_link=>"https://health.adelaide.edu.au/medicine/simulation-skills/")

     StudentProject.create(:title=> "Radiometri Correction of Image Sets Using Genetic Programming", :client=> "Maptek",
     :summary=> "The project aims to normalise the radiometric characteristics of sets of interrelated photos.
      Application of this project will remove the impact of changing lighting conditions during extended image capture.
     The potos are produced for Maptek by an overhead drone. After radiometric smoothing and other quality improving procedures,
     the photos are used to create a 3D model of the space, as well as large composite image. These products are extremely accurate and
     have a cariety of uses.",:image=>seed_image("p1.jpeg"), :client_image=>seed_image("p2.jpeg"), :category=>"Mobile application", 
     :year=>2012, :client_summary=>"One of the most high-tech medical teaching facilities in South Australia, the Adelaide Health Simulation & Skills Centre, 
has been developed to address current and future inter-professional learning needs of health and related workforces. Equipped with a variety of simulation manikins 
and a fully integrated audiovisual system for remote video conferencing, the Centre offers the capacity for all levels of fidelity in simulation education as well as training.
Using state-of-the-art technology to deliver an innovative and effective learning experience, our safe, evidence-based environment supports participants to develop 
clinical and interpersonal skills as well as the confidence and competence to work effectively within their healthcare teams.", 
:client_link=>"https://health.adelaide.edu.au/medicine/simulation-skills/")

     StudentProject.create(:title=> "Deconvolution of Aerial Photography", :client=> " Maptek",
     :summary=> "Photography taken from a moving aerial vehicle will inherently have minor amounts of blurring due to motion.
     To use the photographs in mapping, feature-matching is employed to calculate how they overlap. Even a small blue amount can
     significantly affect the results of these calculations.", :image=>seed_image("p1.jpeg"), :client_image=>seed_image("p2.jpeg"), 
     :category=>"Mobile application",  :client_summary=> "Maptek™ is the leading provider of innovative software, hardware and services for the global 
     mining industry. With more than 30 years of commitment to mine technology research and development, we offer an extensive range of products backed 
     by unparalleled customer service and support.", :client_link=>"http://www.maptek.com/")

     StudentProject.create(:title=> "Breadcrumbs", :client=> "Airborne Research Australia",
     :summary=> "ARA uses light aircraft to perform aerial mappings. They do this by flying in parallel lines across the area.
     During these flights it's possible for spots to be missed, and this will not be known until the data is processed post-flight.
     ARA needs a tool to indicate spots that have been missed while they are in-flight.", :image=>seed_image("p1.jpeg"), 
     :client_image=>seed_image("p2.jpeg"), :category=>"Mech application", :year=>2012, :client_summary=>"Airborne Research Australia (ARA) is a 
     Research Centre at Flinders University and Australia's National Research Aircraft Facility located at Parafield Airport in Adelaide, South Australia. ARA was 
     established in 1996 with funding from the Commonwealth Government's Major National Research Facilities Programme and Flinders University. The core 
     activity of ARA is the use of airborne platforms (special missionaircraft) for a wide range applications and projects, mainly in the Environmental Research &
     Development area. Most of these projects are based on collaborations with colleagues and institutions within Australia and internationally. ", 
    :client_link=>"http://www.airborneresearch.com.au/")

