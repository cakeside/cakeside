require "spec_helper"

describe "changing my password" do
  context "when changing my password" do
    let(:user) { create(:user, :password => "password") }

    before :each do
      visit user_session_path
      within('.form-inline') do
        fill_in('user_email', :with => user.email)
        fill_in('user_password', :with => "password")
      end
      click_button("Sign In")
      visit settings_path
      click_link("Password")
      within(".form-horizontal") do
        fill_in('user_password', :with => "mopass")
        fill_in('user_password_confirmation', :with => "mopass")
      end
      click_button "Change password"
    end

    it "should display a confirmation message" do
      page.should have_content(I18n.translate('passwords.updated'))
    end
  end
end
