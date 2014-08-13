require "rails_helper"

describe "password retrieval", :js => true do
  context "when a user attempts to retrieve their password" do
    let(:user) { create(:user) }

    before :each do
      visit new_session_path
      click_link "Forgot your password?"
      within "#new_user" do
        fill_in "user_email", :with => user.email
      end
      click_button "Send me reset password instructions"
    end

    it "should send them an email with instructions" do
      page.should have_content(I18n.t('devise.passwords.send_instructions'))
    end
  end
end
