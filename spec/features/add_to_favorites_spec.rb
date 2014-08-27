require "rails_helper"

describe "adding a cake to your favorites", :js => true do
  let!(:creation) { create(:creation, user: create(:user), photos: [create(:photo)]) }
  let!(:me) { create(:user, :password => "password") }

  before :each do
    visit login_path
    within('.form-inline') do
      fill_in('session_username', :with => me.email)
      fill_in('session_password', :with => "password")
    end
    click_button("Sign In")
    visit root_path
    click_link(creation.name[0...12])
    click_button("ADD TO FAVORITES")
  end

  it "should redirect you to the cake after" do 
    page.should have_content("Welcome to the fanclub!")
  end
end
