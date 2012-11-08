require 'spec_helper'

describe "Logins" do
  describe "GET /logins" do
    it "works! (now write some real specs)" do
      get "/login"
      response.body.should include("Got an account? Login!")
    end
  end

  describe "Signup for a new user account" do
    it "should make a new user present a confirmation" do
      visit "/login"

      within(".form-horizontal") do
        fill_in('user_name', :with => 'John Smith')
        fill_in('user_city', :with => 'Calgary, Alberta, Canada')
        fill_in('user_email',:with => 'test@example.com')
        fill_in('user_password', :with => 'password')
        fill_in('user_password_confirmation', :with => 'password')
        click_button "submit-registration"
      end

      page.should have_content "You have signed up successfully"
    end
  end
end
