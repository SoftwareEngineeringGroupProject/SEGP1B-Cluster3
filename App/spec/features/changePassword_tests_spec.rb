require 'spec_helper'

describe "to change a password" do

	#register
	user = FactoryGirl.create(:user)
	visit signup_path
	fill_in "username", :with => user.username
	fill_in "email", :with => "sampleMail@gmail.com"
	fill_in "password", :with => user.password
	fill_in "password_confirmation", :with => user.password
	click_button "Continue"

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

end
