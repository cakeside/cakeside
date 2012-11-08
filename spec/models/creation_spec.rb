require 'spec_helper'

describe Creation do
  let(:sut) { FactoryGirl.create(:creation) }

  describe "should be able to set attributes" do
    it "should save name" do
      sut.name="HELLO WORLD"
      sut.save
      Creation.find(sut.id).name.should == "HELLO WORLD"
    end
  end
end
