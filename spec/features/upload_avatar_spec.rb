require "rails_helper"

describe "uploading an avatar", js: true do
  let(:user) { create(:user, :password => "password") }

  before :each do
    visit login_path
    within('.form-inline') do
      fill_in('session_username', :with => user.email)
      fill_in('session_password', :with => "password")
    end
    click_button("Sign In")
    visit new_my_avatar_path
    file = File.expand_path(File.join(Rails.root, '/spec/fixtures/images/gorilla.jpg'))
    within(".edit_photo") do
      attach_file('photo_image', file)
    end
    click_button "Upload picture"
  end

  it "should display a success message" do
    expect(page).to have_content(I18n.t(:avatar_uploaded))
  end
end
