require 'spec_helper'

describe "submit a new project" do

	it "title cannot be blank" do
		visit submit_project_path
		fill_in "title", :with => ""
		fill_in "body", :with => "This is a sample description"
		click_button "SUBMIT"
		page.should have_content("Title can't be blank")
	end

	it "description cannot be blank" do
		visit submit_project_path
		fill_in "title", :with => "This is a sample title"
		fill_in "body", :with => ""
		click_button "SUBMIT"
		page.should have_content("Body can't be blank")
	end

end
