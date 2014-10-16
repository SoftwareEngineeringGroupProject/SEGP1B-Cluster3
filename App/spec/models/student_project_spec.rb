require 'spec_helper'

describe StudentProject do

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
  

end
