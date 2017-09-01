require "rails_helper"

describe "Change settings", js: true do
  let(:user) { create(:user, password: "password") }

  before { http_login(user) }

  it "saves the changes properly" do
    visit my_settings_path
    within(".form-horizontal") do
      fill_in('user_city', with: "Calgary, Alberta, Canada")
      fill_in('user_website', with: "https://www.cakeside.com/")
      fill_in('user_twitter', with: "cakeside")
      fill_in('user_facebook', with: "cakeside")
    end
    click_button "Save changes"
    expect(page).to have_content(I18n.translate(:profile_saved))
  end
end
