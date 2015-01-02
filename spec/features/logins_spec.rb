require 'rails_helper'

describe "Logins" do
  describe "GET /login" do
    it "should be able to reach the login page" do
      visit login_path
      expect(page).to have_content("Got an account? Login!")
    end

    context "when an email is registered", :js => true do
      let!(:user) { create(:user, :password => "password") }

      before :each do
        visit login_path
        within('.form-inline') do
          fill_in('session_username', :with => user.email)
          fill_in('session_password', :with => "password")
        end
        click_button("Sign In")
      end

      it "should let the user signin with the proper password" do
        expect(page).to have_content("Log Out")
      end

      it "should not have an error" do
        expect(page).to_not have_content(I18n.t('devise.failure.invalid'))
      end
    end

    context "when an email is not known", js: true do
      before :each do
        visit login_path
        within('.form-inline') do
          fill_in('session_username', :with => 'test@example.com')
          fill_in('session_password', :with => 'password')
        end
        click_button "Sign In"
      end

      it "should display an error message" do
        expect(page).to have_content("invalid email or password.")
      end
    end
  end
end
