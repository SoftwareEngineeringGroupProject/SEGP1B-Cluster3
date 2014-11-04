require 'spec_helper'

describe "edit a profile" do
	it "input with invalid email" do
		visit edit_profile_path
		fill_in "fname", :with => "fistName"
		fill_in "lname", :with => "lastName"
		fill_in "email", :with => "blahblah"
		fill_in "phone", :with => "12345678"
		click_button "Update Details"
		page.should have_content("Email Address is Invalid")
	end

	it "input with invalid email" do
		visit edit_profile_path
		fill_in "fname", :with => "fistName"
		fill_in "lname", :with => "lastName"
		fill_in "email", :with => "12345678@gmail.com"
		fill_in "phone", :with => "12345678"
		click_button "Update Details"
		page.should_not have_content("Email Address is Invalid")
	end
end
