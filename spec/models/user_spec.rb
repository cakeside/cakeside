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
      let(:user) {User.new}
      before(:each) do
        user.update_attributes(:website => 'http://example.com')
      end
      it "can validate" do
        user.errors[:website].any?.should == false
      end
      it "should not have any validation error messages" do
        user.errors[:website].should === []
      end
    end
    describe "when the url is not valid" do
      let(:user) {User.new}
      before(:each) do
        user.update_attributes(:website => 'blah')
      end
      it "cannot validate" do
        user.errors[:website].any?.should == true
      end
      it "should have an error message" do
        user.errors[:website].should === ["is invalid"]
      end
    end
  end
end
