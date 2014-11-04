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

	it "invalid email " do
		visit signup_path
		fill_in "email", :with => "e45tbse5rtyw4"
		click_button "Continue"
		page.should have_content("Email is invalid")
	end

	it "valid email " do
		visit signup_path
		fill_in "email", :with => "123@gmail.com"
		click_button "Continue"
		page.should_not have_content("Email is invalid")
	end

#password tests

	it "invalid password can't be blank" do
		visit signup_path
		fill_in "password", :with => ""
		click_button "Continue"
		page.should have_content("Password is too short")
	end

	it "invalid password can't be too short" do
		visit signup_path
		fill_in "password", :with => ""
		click_button "Continue"
		page.should have_content("Password is too short")
	end

	it "invalid password can't be too long" do
		visit signup_path
		fill_in "password", :with => "qw4rtd8oynxa8i8qw24ry7n2389yr4nq398y*R*TR#"
		click_button "Continue"
		page.should have_content("Password is too long")
	end

#confirm password

	it "invalid password due to two inputs does not match" do
		visit signup_path
		fill_in "password", :with => "qw4rtd8oyn"
		fill_in "password_confirmation", :with => ""
		click_button "Continue"
		page.should have_content("Password confirmation doesn't match Password")
	end

	it "valid password due to two inputs match" do
		visit signup_path
		fill_in "password", :with => "qw4rtd8oyn"
		fill_in "password_confirmation", :with => "qw4rtd8oyn"
		click_button "Continue"
		page.should_not have_content("Password confirmation doesn't match Password")
	end
end


describe "login system before register" do
	it "login user with invalid account" do
		user = FactoryGirl.create(:user)
		visit login_path
		fill_in "username_or_email", :with => user.username
		fill_in "login_password", :with => "aaasssss"
		click_button "LOG IN"
		page.should have_content("Invalid Username or Password")
	end

	it "login user with valid account which register" do
		

		#login
		visit login_path
		fill_in "username_or_email", :with => user.username
		fill_in "login_password", :with => user.password
		click_button "LOG IN"
		page.should have_content("Account Successfuly Created. Please Log In to Continue")
	end

end
