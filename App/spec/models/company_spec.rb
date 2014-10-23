require 'spec_helper'

describe Company do
  
  # VALID TESTING
  before do
    @comp = Company.new(name: "andrew inc", username: "andrewInc", address: "4 frome street north adelaide", 
    	phone: "0412345678", reference_code: "test", email: "andrewinc@andrew.com", website: "andrewinc.com", user_id: "12321")
  end

  subject { @comp }

  it { should respond_to(:name) }
  it { should respond_to(:username) }
  it { should respond_to(:address) }
  it { should respond_to(:phone) }
  it { should respond_to(:reference_code) }
  it { should respond_to(:email) }
  it { should respond_to(:website) }
  it { should respond_to(:user_id) }

  it { should be_valid }

#presence tests
	describe "a company must have a name" do
		before { @comp.name = " " }
		it { should_not be_valid }
	end

	describe "a company must have a name" do
		before { @comp.address = " " }
		it { should_not be_valid }
	end

	describe "a company must have a webpage" do
		before { @comp.website = " " }
		it { should_not be_valid }
	end

	describe "a company must have a phone number" do
		before { @comp.phone = " " }
		it { should_not be_valid }
	end

	describe "a company must have a user ID" do
		before { @comp.user_id = " " }
		it { should_not be_valid }
	end

end
