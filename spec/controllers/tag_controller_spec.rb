require "spec_helper"

describe TagsController do
  describe :show do
    let(:tag) { "cake" }
    let(:tagged_tutorial) { FactoryGirl.create(:tutorial) }
    let(:untagged_tutorial) { FactoryGirl.create(:tutorial) }
    let(:tagged_cake) { FactoryGirl.create(:creation) }
    let(:untagged_cake) { FactoryGirl.create(:creation) }

    before :each do
      tagged_tutorial.tag_list.add(tag)
      tagged_tutorial.save
      tagged_cake.tag_list.add(tag)
      tagged_cake.save
      get :show, :id => tag
    end

    it "should return each tutorial that is tagged" do
      assigns(:tutorials).should include(tagged_tutorial)
    end

    it "should not return tutorials that are not tagged" do
      assigns(:tutorials).should_not include(untagged_tutorial)
    end

    it "should return each cake that is tagged" do
      assigns(:creations).should include(tagged_cake)
    end

    it "should not return cakes that are not tagged" do
      assigns(:creations).should_not include(untagged_cake)
    end

    it "should include the tag" do
      assigns(:tag).should == tag
    end
  end
end
