require 'rails_helper'

describe Creation do
  let(:sut) { Creation.new }

  describe "should be able to set attributes" do
    it "should save name" do
      sut.name="HELLO WORLD"
      sut.save
      Creation.find(sut.id).name.should == "HELLO WORLD"
    end
  end

  describe "when loading a bunch of creations" do
    let!(:oldest) { create(:creation) }
    let!(:newest) { create(:creation) }
    let(:results) { Creation.all }

    it "should load the newest first" do
      results.first.should == newest
    end

    it "should load the oldest last" do
      results.last.should == oldest
    end
  end

  describe "#liked_by" do
    let(:user) { create(:user) }
    let(:creation) { create(:creation) }

    context "when the user already likes the creation" do
      let!(:favorite) { creation.favorites.create(:user => user) }
      let(:result) { creation.liked_by(user) }

      it "returns the existing favorite" do
        result.should == favorite
      end
    end

    context "when the user does not like the creation yet" do
      let(:result) { creation.liked_by(user) }

      it "creates a new favorite" do
        result.should_not be_nil
        result.user.should == user
        result.creation.should == creation
        creation.reload.favorites.count.should == 1
      end
    end
  end
end
