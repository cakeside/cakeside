require 'spec_helper'

describe Creation do
  let(:sut) { FactoryGirl.create(:creation) }

  context "when not published" do
    it "should return false" do
      sut.is_published?.should == false
    end
  end
  context "when published" do
    it "should return true" do
      sut.is_published?.should == true
    end
    before(:each) do
      sut.migrate_primary_image
    end
  end

end
