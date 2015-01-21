require "rails_helper"

describe "adding a cake to your favorites" do
  let!(:creation) { create(:creation, user: create(:user), photos: [create(:photo)]) }
  let!(:me) { create(:user, password: "password") }

  before :each do
    visit login_path
    within('.form-inline') do
      fill_in('session_username', with: me.email)
      fill_in('session_password', with: "password")
    end
    click_button("Sign In")
    visit root_path
    click_link(creation.name[0...12])
    puts page.html
    click_link_or_button("add-to-favorites-button")
  end

  it "redirects you to the cake after" do
    expect(page).to have_content("This has been added to your favorites")
  end
end
