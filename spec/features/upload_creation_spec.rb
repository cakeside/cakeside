require "rails_helper"

describe "uploading a new creation", :js => true do
  let!(:user) { create(:user, password: "password") }
  let!(:category_1) { create(:category) }
  let!(:category_2) { create(:category) }

  before :each do
    visit user_session_path
    within('.form-inline') do
      fill_in('user_email', with: user.email)
      fill_in('user_password', with: "password")
    end
    click_button("Sign In")
    click_link("Add Creation")
    wait_for_ajax
    within(".form-horizontal") do
      fill_in("cake_name", with: "yummy cake")
      fill_in("cake_watermark", with: "yummy")
      fill_in("cake_story", with: "this was just so damn yummy so i ate it alone.")
      select(category_2.name, from: 'cake_category_id')
      #fill_in("cake_tags", :with => "cake, yummy")
    end
    click_button("Create")
  end

  it "should get them to the image upload page" do
    expect(page).to have_text("yummy cake")
  end
end
