require "rails_helper"

describe "password retrieval", :js => true do
  context "when a user attempts to retrieve their password" do
    let(:user) { create(:user) }

    before :each do
      visit login_path
      click_link "Forgot your password?"
      within "#new_user" do
        fill_in "user_email", :with => user.email
      end
      click_button "Send me reset password instructions"
    end

    it "should send them an email with instructions" do
      expect(page).to have_content(I18n.t('devise.passwords.send_instructions'))
    end
  end

  context "when a password is reset" do
    let(:user) { create(:user, reset_password_token: SecureRandom.hex(32)) }

    it "lets them log in with the new password" do
      visit edit_password_path(user.reset_password_token)
      fill_in "user_password", with: 'donkey'
      click_button "Change my password"
      within('.form-inline') do
        fill_in('session_username', with: user.email)
        fill_in('session_password', with: "donkey")
      end
      click_button("Sign In")
      expect(page).to have_content("Log Out")
    end
  end
end
