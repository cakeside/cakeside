require 'spec_helper'

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
end
