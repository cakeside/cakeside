require 'spec_helper'

describe "Profiles" do
  describe "GET /profiles" do
    it "works! (now write some real specs)" do
      visit profiles_path
      page.should have_content 'CakeSide'
    end
  end

end
