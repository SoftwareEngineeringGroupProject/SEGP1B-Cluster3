require 'spec_helper'

describe AssignedStudent do
  pending "add some examples to (or delete) #{__FILE__}"

#valid test
	before do
		@assignedStudent = AssignedStudent.new(studentID: "a1234567", project_id: "1234", created_at: "12-21-2012", updated_at: "13-31-2013", group_name: "SEGP" )
	end

	subject { @assignedStudent }

	it { should respond_to(:studentID) }
	it { should respond_to(:project_id) }
	it { should respond_to(:created_at) }
	it { should respond_to(:13-31-2013) }
	it { should respond_to(:group_name) }

	it { should be_valid }

	describe "must have student id" do
		before { @assignedStudent.studentID = " " }
		it { should_not be_valid }
	end

	describe "must have project id" do
		before { @assignedStudent.project_id = " " }
		it { should_not be_valid }
	end

	describe "must have project id" do
		before { @assignedStudent.group_name = " " }
		it { should_not be_valid }
	end


end
