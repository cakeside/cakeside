require "rails_helper"

describe "adding a cake to your favorites", :js => true do
  let!(:creation) { create(:creation, user: create(:user), photos: [create(:photo)]) }
  let!(:me) { create(:user, :password => "password") }

  before :each do
    visit new_session_path
    within('.form-inline') do
      fill_in('user_email', :with => me.email)
      fill_in('user_password', :with => "password")
    end
    click_button("Sign In")
    click_link(creation.name)
    click_button("ADD TO FAVORITES")
  end

  it "should redirect you to the cake after" do 
    page.should have_content("Welcome to the fanclub!")
  end
end
