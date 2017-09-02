require "rails_helper"

describe "adding a cake to your favorites" do
  let!(:creation) { create(:creation, user: create(:user), photos: [create(:photo)]) }
  let!(:me) { create(:user, password: "password") }

  before { http_login(me) }

  it "redirects you to the cake after" do
    visit root_path
    click_link(creation.name[0...12])
    click_link_or_button("add-to-favorites-button")
    expect(page).to have_content("This has been added to your favorites")
  end
end
