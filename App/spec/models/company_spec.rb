require 'spec_helper'

describe Company do
  
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


end
