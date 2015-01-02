require 'rails_helper'

describe "Tutorials" do
  describe "GET /tutorials" do
    it "works! (now write some real specs)" do
      visit tutorials_path
      expect(page).to have_content("CakeSide")
    end
  end
end
