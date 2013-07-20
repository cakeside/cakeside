require 'spec_helper'

describe User do
  describe :properties do
    it { should respond_to :name }
    it { should respond_to :email }
    it { should respond_to :twitter }
    it { should respond_to :facebook }
    it { should respond_to :city }
    it { should respond_to :latitude }
    it { should respond_to :longitude }
    it { should respond_to :password }
    it { should respond_to :remember_me }
    it { should respond_to :website }
    it { should respond_to :interests }
    it { should respond_to :creations }
    it { should respond_to :favorites }
    it { should respond_to :tutorials }
    it { should respond_to :avatar }
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

  describe "when checking if a user already likes a creation" do
    let(:sut) { create(:user) }
    let(:cake) { create(:creation) }

    describe "when they do" do
      before :each do
        sut.add_favorite(cake)
      end

      let(:result) { sut.already_likes(cake) }

      it "should return true" do
        result.should be_true
      end
    end

    describe "when they do not" do
      let(:result) { sut.already_likes(cake) }

      it "should return false" do
        result.should be_false
      end
    end
  end

  describe "when a user adds a cake to their favorites" do
    let(:sut) { create(:user) }
    let!(:cake) { create(:creation) }

    context "when the cake is already in their favorites" do
      let!(:favorite) { create(:favorite, :creation => cake, :user => sut) }
      let(:result) { sut.add_favorite(cake) }

      it "should return their existing favorite" do
        result.should == favorite
      end
    end

    context "when they have not liked it before" do
      let(:result) { sut.add_favorite(cake) }

      it "should return a new favorite" do
        result.should be_a(Favorite)
      end

      it "should specify the user" do
        result.user.should == sut
      end

      it "should specify the creation" do
        result.creation.should == cake
      end
    end
  end

  describe "when loading all the users" do
    let!(:first_person) { create(:user, :creations_count => 0) }
    let!(:second_person) { create(:user, :creations_count => 1) }

    let(:results) { User.all }

    it "should load the person with the most cakes first" do
      results.first.should == second_person
    end

    it "should load the person with the least cakes last" do
      results.last.should == first_person
    end
  end
end
