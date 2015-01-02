require "rails_helper"

describe "changing my password", js: true do
  context "when changing my password" do
    let(:user) { create(:user, :password => "password") }

    before :each do
      visit login_path
      within('.form-inline') do
        fill_in('session_username', :with => user.email)
        fill_in('session_password', :with => "password")
      end
      click_button("Sign In")
      visit my_dashboard_path
      click_link("Account")
      within(".form-horizontal") do
        fill_in('user_password', :with => "mopass")
        fill_in('user_password_confirmation', :with => "mopass")
      end
      click_button "Update password"
    end

    it "should display a confirmation message" do
      expect(page).to have_content(I18n.translate('passwords.updated'))
    end
  end
end
