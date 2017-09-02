require "rails_helper"

describe "uploading an avatar", js: true do
  let(:user) { create(:user, :password => "password") }
  let(:file) { File.expand_path(File.join(Rails.root, '/spec/fixtures/images/gorilla.jpg')) }

  before { http_login(user) }

  it "displays a success message" do
    visit new_my_avatar_path
    within(".new_photo") do
      attach_file('photo_image', file)
    end
    click_button "Upload picture"
    expect(page).to have_content(I18n.t(:avatar_uploaded))
  end
end
