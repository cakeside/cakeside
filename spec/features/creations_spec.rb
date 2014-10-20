require 'rails_helper'

describe "Creations", js: true do
  describe "GET /creations" do
    before :each do
      visit cakes_path
    end

    it "loads the page" do
      expect(page).to have_content("CakeSide")
    end
  end
end
