require 'spec_helper'

describe AssignedStudent do
  pending "add some examples to (or delete) #{__FILE__}"

#valid test
	before do
		@assignedStudent = AssignedStudent.new(studentID: "a1234567", project_id: "1234", group_name: "SEGP" )
	end

	subject { @assignedStudent }

	it { should respond_to(:studentID) }
	it { should respond_to(:project_id) }
	it { should respond_to(:created_at) }
	it { should respond_to(:created_at) }
	it { should respond_to(:updated_at) }
	it { should respond_to(:group_name) }

	it { should be_valid }


#not null test
	describe "must have student id" do
		before { @assignedStudent.studentID = " " }
		it { should_not be_valid }
	end

	describe "must have project id" do
		before { @assignedStudent.project_id = " " }
		it { should_not be_valid }
	end

	describe "must have project grou name" do
		before { @assignedStudent.group_name = " " }
		it { should_not be_valid }
	end

#unique test

	describe "the student id must be unique" do
		before do
			dupStudent = @assignedStudent.dup
			dupStudent.studentID = @assignedStudent.studentID
  			dupStudent.save
		end

		it {should_not be_valid}
	end





end
