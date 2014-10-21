require 'rails_helper'

describe "PasswordResets" do
  it "login user with invalid account" do
    user = FactoryGirl.create(:user)
    visit login_path
    fill_in "username_or_email", :with => user.username
    fill_in "login_password", :with => user.password
    click_button "LOG IN"
    page.should have_content("Invalid Username or Password")
  end

  it "login user with valid account" do
    
  end
end

