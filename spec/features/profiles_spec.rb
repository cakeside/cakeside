require 'rails_helper'

describe "Profiles" do
  describe "GET /profiles" do
    it "it loads" do
      visit profiles_path
      expect(page).to have_content('CakeSide')
    end
  end
end
