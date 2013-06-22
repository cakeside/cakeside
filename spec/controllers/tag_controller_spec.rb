require "spec_helper"

describe TagsController do
  describe :index do
    let(:cake) { FactoryGirl.create(:creation) }
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      user.tag(cake, :with => "cake", :on => :tags)
      get :index
    end

    it "should load all the tags" do
      assigns(:tags).count.should == 1
      assigns(:tags).first.name.should == "cake"
    end
  end
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
