require 'spec_helper'

describe User do
  describe "when a user already likes a creation" do 
    it "should not let the user like it again" do
      creation = FactoryGirl.create(:creation)
      user = FactoryGirl.create(:user)
      user.add_favorite(creation)
      user.add_favorite(creation)
      creation.favorites.length.should eq(1)
    end
  end
  describe "when a website url is supplied" do
    describe "when the url is valid" do
      it "can validate" do
        user = User.new
        user.update_attributes(:website => 'http://example.com')
        user.errors[:website].any?.should == false
      end
    end
    describe "when the url is not valid" do
      it "cannot validate" do
        user = User.new
        user.update_attributes(:website => 'blah')
        user.errors[:website].any?.should == true
      end
    end
  end
end
