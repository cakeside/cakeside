require "rails_helper"

describe "Change settings", js: true do
  let(:user) { create(:user, :password => "password") }

  before :each do
    visit login_path
    within('.form-inline') do
      fill_in('session_username', :with => user.email)
      fill_in('session_password', :with => "password")
    end
    click_button("Sign In")
    visit my_settings_path
    within(".form-horizontal") do
      fill_in('user_city', :with => "Calgary, Alberta, Canada")
      fill_in('user_website', :with => "http://mokhan.ca/")
      fill_in('user_twitter', :with => "mocheen")
      fill_in('user_facebook', :with => "yeah right!")
    end
    click_button "Save changes"
  end

  it "should save the changes properly" do
    page.should have_content(I18n.translate(:profile_saved))
  end
end
