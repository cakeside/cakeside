require "rails_helper"

describe "Registration", js: true do
  context "when an email is not registered" do
    it "lets you register with that email address" do
      visit login_path
      within("#new_user") do
        fill_in('user_name', with: 'John Smith')
        fill_in('user_email', with: FFaker::Internet.email)
        fill_in('user_password', with: 'password')
        check('accepted')
        click_button "submit-registration"
      end
      expect(page).to have_content("Dashboard")
    end
  end
end
