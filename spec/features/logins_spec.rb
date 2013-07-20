require 'spec_helper'

describe "Logins" do
  describe "GET /logins" do
    it "works! (now write some real specs)" do
      visit '/login'
      page.should have_content("Got an account? Login!")
    end
  end
end
