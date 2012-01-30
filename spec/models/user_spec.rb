require 'spec_helper'

describe User do
  describe "when a user already likes a creation" do 
    it "should not let the user like it again" do
      # creation = Creation.new
      creation = FactoryGirl.build(:creation)
      user = FactoryGirl.create(:user)
      user.add_favorite(creation)
      user.add_favorite(creation)
      creation.favorites.length.should eq(1)
    end
  end
end
