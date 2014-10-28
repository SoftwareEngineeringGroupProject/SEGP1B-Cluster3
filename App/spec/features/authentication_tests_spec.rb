require 'spec_helper'

describe "register an account to use" do

	it "invalid too short for username" do
		visit signup_path
		fill_in "username", :with => "12"
		click_button "Continue"
		page.should have_content("Username is too short")
	end

	it "invalid to long for username" do
		visit signup_path
		fill_in "username", :with => "121231231231231231233123123"
		click_button "Continue"
		page.should have_content("Username is too long")
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
