require 'spec_helper'

describe "to change a password" do	

	#current password testing

	it "use invalid current password" do
		visit change_pw_path
		fill_in "login_password", :with => "blahsssss"
		page.should have_content("Current Password is incorrect!")
	end

	it "use valid current password" do
		visit change_pw_path
		fill_in "login_password", :with => user.password
		page.should_not have_content("Current Password is incorrect!")
	end

	#new password testing

	it "use valid current password" do
		visit change_pw_path
		fill_in "login_password", :with => user.password
		fill_in "new_password", :with => "12"
		page.should have_content("New password must be at least 6 chracters in length")
	end

	#confirm password testing

	it "use valid current password" do
		visit change_pw_path
		fill_in "login_password", :with => user.password
		fill_in "new_password", :with => "w345hsztusr7ht"
		fill_in "confirm_password", :with => "asdaaaaaa"
		page.should have_content("Confirmation Password does not match New Password")
	end

	#successful testing

	it "use valid current password" do
		visit change_pw_path
		fill_in "login_password", :with => user.password
		fill_in "new_password", :with => "w345hsztusr7ht"
		fill_in "confirm_password", :with => "w345hsztusr7ht"
		page.should have_content("Password Successfully Updated")
	end
end
