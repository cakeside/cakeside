require "spec_helper"

describe CreationTagsController do
  describe "#index" do
    let(:cake) { create(:creation) }
    let(:user) { create(:user) }

    before :each do
      user.tag(cake, :with => "cake", :on => :tags)
      get :index
    end

    it "should load all the tags" do
      assigns(:tags).count.should == 1
      assigns(:tags).first.name.should == "cake"
    end
  end
  describe "#show" do
    let(:user) { create(:user) }
    let(:tag) { "cake" }
    let(:tagged_tutorial) { create(:tutorial) }
    let(:untagged_tutorial) { create(:tutorial) }
    let(:tagged_cake) { create(:creation, :photos_count => 1) }
    let(:untagged_cake) { create(:creation) }

    before :each do
      user.tag(tagged_tutorial, :with => tag, :on => :tags)
      user.tag(tagged_cake, :with => tag, :on => :tags)
      get :show, :id => tag
    end

    it "should include the total tutorials tagged" do
      assigns(:total_tutorials).should == 1
    end

    it "should include the total creations tagged" do
      assigns(:total_creations).should == 1
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
