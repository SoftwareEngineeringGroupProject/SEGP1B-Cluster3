#create initial admin
@initialadmin = User.new({:username => "administrator", :email => "admin@admin.com", :password => "cluster3", :password_confirmation => "cluster3", :fname => "Default", :lname => "Admin", :companyname => "Cluster 3", :address => "NA", :phone => "NA", :website => "NA"})
@initialadmin.save
