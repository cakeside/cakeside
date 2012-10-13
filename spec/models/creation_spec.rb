require 'spec_helper'

describe Creation do
  let(:sut) { FactoryGirl.create(:creation) }

  context "when not published" do
    it "should return false" do
      sut.is_published.should == false
    end
  end
  context "when published" do
    it "should return true" do
      Creation.find(sut.id).is_published.should == true
    end
    before(:each) do
      sut.migrate_primary_image
    end
  end

  describe "should be able to set attributes" do
    it "should save is_published" do
      sut.is_published=true
      sut.save
      Creation.find(sut.id).is_published.should == true
    end
  end
end
