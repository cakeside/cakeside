require 'spec_helper'

describe "Creations" do
  describe "GET /creations" do
    before :each do
      visit creations_path
    end

    it "should load the page properly" do
      page.should have_content("CakeSide")
    end
  end
end
