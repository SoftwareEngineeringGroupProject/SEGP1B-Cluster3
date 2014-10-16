require 'spec_helper'

describe User do

  before do
    @user = User.new(acctype: "industry", username: "andrew", email: "andrew@example.com",
     fname: "andrew", lname: "nguyen", companyname: "andrew inc", address: "4 first street woodville north", phone: "0482551234", website: "andrew.com" )
  end

  subject { @user }

  it { should respond_to(:acctype) }
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:hashed_password) }
  it { should respond_to(:salt) }
  it { should respond_to(:fname) }
  it { should respond_to(:lname) }
  it { should respond_to(:companyname) }
  it { should respond_to(:address) }
  it { should respond_to(:phone) }
  it { should respond_to(:website) }



end
