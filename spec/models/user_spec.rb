#require 'spec_helper'

describe User do
  #describe "when a user already likes a creation" do 
    #it "should not let the user like it again" do
      #creation = FactoryGirl.create(:creation)
      #user = FactoryGirl.create(:user)
      #user.add_favorite(creation)
      #user.add_favorite(creation)
      #creation.favorites.length.should eq(1)
    #end
  #end
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
  describe "when commenting on a creation" do
    let(:comment) { fake }
    let(:creation) { fake }
    let(:sut) { User.new }

    it "should create a new comment" do
      @result.should == comment
    end
    before(:each) do
      Comment.stub(:create_for).with(sut, creation, "cool cake").and_return(comment)
      @result = sut.comment_on(creation, "cool cake")
    end
  end
end
