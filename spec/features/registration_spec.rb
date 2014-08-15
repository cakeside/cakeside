require "rails_helper"

describe "Registration", :js => true do
  context "when an email is not registered" do
    before :each do
      visit login_path
      within(".form-horizontal") do
        fill_in('user_name', :with => 'John Smith')
        fill_in('user_email',:with => Faker::Internet.email)
        fill_in('user_password', :with => 'password')
        fill_in('user_password_confirmation', :with => 'password')
        click_button "submit-registration"
      end
    end

    it "should let you register with that email address" do
      page.should have_content "You have signed up successfully"
    end

    xit "should take you to the settings page" do
      page.should have_content("Settings")
    end
  end
end
