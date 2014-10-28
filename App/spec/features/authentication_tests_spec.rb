require 'spec_helper'

describe "register an account to use" do

#user name tests

	it "invalid username can't be blank" do
		visit signup_path
		fill_in "username", :with => ""
		click_button "Continue"
		page.should have_content("Username can't be blank")
	end

	it "invalid too short for username" do
		visit signup_path
		fill_in "username", :with => "12"
		click_button "Continue"
		page.should have_content("Username is too short")
	end

	it "invalid to long for username" do
		visit signup_path
		fill_in "username", :with => "12123*H@EOIUR(@#*EDJUO$ITRJ#O*R3uw9284fhw4123"
		click_button "Continue"
		page.should have_content("Username is too long")
	end

# email tests

	it "invalid email can't be blank" do
		visit signup_path
		fill_in "email", :with => ""
		click_button "Continue"
		page.should have_content("Email can't be blank")
	end



end


describe "login system before register" do
  it "login user with invalid account" do
    user = FactoryGirl.create(:user)
    visit login_path
    fill_in "username_or_email", :with => user.username
    fill_in "login_password", :with => user.password
    click_button "LOG IN"
    page.should have_content("Invalid Username or Password")
  end



end
