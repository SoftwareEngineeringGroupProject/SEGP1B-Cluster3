require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "login" do
    before { visit '/login' }

    it { should have_content('Login') }

    describe "with invalid information" do
      before { click_button "LOG IN" }

      it { should have_content('Sorry... Invalid Username or Password') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { log_in user }

      describe "followed by logout" do
        before { click_link "Logout"; visit '/'}
        it { should have_link('Login') }
      end
    end

  end
end


