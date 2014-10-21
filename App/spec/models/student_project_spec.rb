require 'spec_helper'

describe StudentProject do

# VALID TESTING
  before do
    @studProject = StudentProject.new(title: "example project", summary: "summary......",
    									client: "aus gov", category: "web application")
  end

  subject { @studProject }

  it { should respond_to(:title) }
  it { should respond_to(:summary) }
  it { should respond_to(:client) }
  it { should respond_to(:category) }
  it { should respond_to(:image) }
  it { should respond_to(:company) }
  it { should respond_to(:year) }
  it { should respond_to(:client_image) }

  it { should be_valid }

# TESTING FOR NON VALID ARGUMENTS
#       validates_presence_of :title, :summary, :client, :category

  describe "when title is not present" do
    before { @studProject.title = " " }
    it { should_not be_valid }
  end

  describe "when summary is not present" do
    before { @studProject.summary = " " }
    it { should_not be_valid }
  end

  describe "when client is not present" do
    before { @studProject.client = " " }
    it { should_not be_valid }
  end

  describe "when category is not present" do
    before { @studProject.category = " " }
    it { should_not be_valid }
  end


# TESTING ATTRIBUTES

	# describe "projects have many students" do
	#   @studProject.should have_at_least(1).error_on(:students) 
	# end


	# uniqueness
  describe "when title is already taken" do
  	before do 
  		project_with_same_title = @studProject.dup
  		project_with_same_title.title = @studProject.title.upcase
  		project_with_same_title.save
  	end

  	it {should_not be_valid}
  end


end
