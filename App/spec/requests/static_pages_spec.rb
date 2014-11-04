require 'spec_helper'

describe "Static pages" do

	subject { page }


 # TESTING PAGE PATHS AND SIMPLE CONTENT
	describe "Home page" do
		before { visit '/' }
    it { should have_content('Home') }
  end

  describe "Login page" do
    before { visit '/login' }
    it { should have_content('Login') }
  end

  describe "Register page" do
    before { visit '/signup' }
    it { should have_content('Industry Partner Signup') }
  end

  describe "Project Portfolio page" do
    before { visit '/projects' }
    it { should have_content('Project Portfolio') }
  end

  describe "Information page" do
    before { visit '/projects/info' }
    it { should have_content('Information') }
  end

  describe "Contact page" do
    before { visit '/contacts' }
    it { should have_content('Contacts') }
  end

  describe "Bad URL page" do
    before { visit '/adaiediuw123u235k3hrs/321edsdr43' }
    it { should have_content('404') }
  end

  #TESTING LINKS
  it "should have the right links on the layout" do
    visit '/'
    click_link "Home"
    expect(page).to have_content('Home')
    click_link "Login"
    expect(page).to have_content('Login')
    click_link "Register"
    expect(page).to have_content('Industry Partner Signup')
    click_link "Project Gallery"
    expect(page).to have_content('Project Portfolio')
    click_link "Information"
    expect(page).to have_content('Information')
    click_link "Contact"
    expect(page).to have_content('Contacts')
  end
end