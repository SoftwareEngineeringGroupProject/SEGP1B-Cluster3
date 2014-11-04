require 'spec_helper'

describe Project do

#valid test

 	before do
		
		@project = Project.new(title: "Test Project", body: "a test project is a project for test.
												 it include some sentences in project body.
												 and the content length should be large that we can see if it still works.
												the content length should be large.the content length should be large.
												the content length should be large
												the content length should be large
												the content length should be large.
												the content length should be large.
												the content length should be large.
												the content length should be large.
												the content length should be large.")

	end

	subject { @project }

	it{ should respond_to(:title) }
	it{ should respond_to(:body) }
	it{ should respond_to(:company_id) }
	it{ should respond_to(:attched_id) }
	it{ should respond_to(:status) }
	it{ should respond_to(:created_at) }
	it{ should respond_to(:updated_at) }
	it{ should respond_to(:in_cart) }
	it{ should respond_to(:user_id) }
	it{ should respond_to(:compl_time) }
	it{ should respond_to(:man_hours) }
	it{ should respond_to(:languages) }
	it{ should respond_to(:system_req) }
	it{ should respond_to(:compat_req) }
	it{ should respond_to(:student_req_lang) }
	it{ should respond_to(:student_req_concepts) }
	it{ should respond_to(:student_police_check) }
	it{ should respond_to(:student_security) }
	it{ should respond_to(:extra_details) }


#presence testing

	describe "a project must have a title" do
		before { @project.title = " " }
		it { should_not be_valid }
	end

	describe "a project must have a body to keep content" do
		before { @project.body = " " }
		it { should_not be_valid }
	end

#attachment type tests
#valid
	describe "a PDF file type should be valid" do
		it "should be invalid" do
			attachment_content_type = "application/pdf"
			expect(@project).to be_valid
		end
	end
	
	describe "an Excel file type should be valid" do
		it "should be invalid" do
			attachment_content_type = "application/vnd.ms-excel"
			expect(@project).to be_valid
		end
	end

	describe "a Microsoft Word document type should be valid" do
		it "should be invalid" do
			attachment_content_type = "application/msword"
			expect(@project).to be_valid
		end
	end

	describe "a text file type should be valid" do
		it "should be invalid" do
			attachment_content_type = "text/plain"
			expect(@project).to be_valid
		end
	end

#invalid
	describe "a JPG picture file type should not be valid" do
		it "should not be invalid" do
			attachment_content_type = "image/jpg"
			expect(@project).not_to be_valid
		end
	end
	
	describe "a PNG picture file type should not be valid" do
		it "should not be invalid" do
			attachment_content_type = "image/png"
			expect(@project).not_to be_valid
		end
	end

	describe "a exe binary runnable file type should not be valid" do
		it "should not be invalid" do
			attachment_content_type = "application/octet-stream"
			expect(@project).not_to be_valid
		end
	end

	describe "an octet-stream file type eg exe,bin,class should not be valid" do
		it "should not be invalid" do
			attachment_content_type = "application/octet-stream"
			expect(@project).not_to be_valid
		end
	end
end
