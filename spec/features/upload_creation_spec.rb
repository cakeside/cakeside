require "spec_helper"

describe "uploading a new creation", :js => true do
  let!(:user) { create(:user, :password => "password") }
  let!(:category_1) { create(:category) }
  let!(:category_2) { create(:category) }

  before :each do
    visit user_session_path
    within('.form-inline') do
      fill_in('user_email', :with => user.email)
      fill_in('user_password', :with => "password")
    end
    click_button("Sign In")
    click_link("Add Creation")

    within(".form-horizontal") do
      fill_in("creation_name", :with => "yummy cake")
      fill_in("creation_watermark", :with => "yummy")
      fill_in("creation_story", :with => "this was just so damn yummy so i ate it alone.")
      select(category_2.name, :from => 'category_id')
      #fill_in("creation_tags", :with => "cake, yummy")
    end
    click_button("NEXT STEP")
  end

  it "should get them to the image upload page" do
    page.should have_content("Step 2 of 2")
  end
end
