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

end
