require "rails_helper"

describe "uploading an avatar" do
  let(:user) { create(:user, :password => "password") }

  before :each do
    visit new_session_path
    within('.form-inline') do
      fill_in('sessions_username', :with => user.email)
      fill_in('sessions_password', :with => "password")
    end
    click_button("Sign In")
    visit edit_my_avatar_path(user)
    file = File.expand_path(File.join(Rails.root, '/spec/fixtures/images/gorilla.jpg'))
    within(".edit_avatar") do
      attach_file('avatar_avatar', file)
    end
    click_button "Upload picture"
  end

  it "should display a success message" do
    page.should have_content(I18n.t(:avatar_uploaded))
  end
end
