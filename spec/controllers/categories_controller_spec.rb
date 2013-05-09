require 'spec_helper'

describe CategoriesController do
  before(:each) do
    @creation = FactoryGirl.create(:creation)
    @category = FactoryGirl.create(:category, :creations => [@creation])
  end

  describe "GET show" do
    context "when there is NO category that matches the slug" do
      before(:each) do
        get :show, :id => "!#{@category.slug}"
      end
      it "should redirect to tags" do
        response.should redirect_to("/tags/!#{@category.slug}")
      end
    end
    context "when there is a category that matches the slug" do
      context "when there are creations in the category" do
        before { get :show, :id => @category.slug }

        it "should return the creations in the category" do
          assigns(:creations).should == [@creation]
        end
        it "should return the category" do
          assigns(:category).should == @category
        end
      end
      context "when there are no creations in the category" do
        let(:other_category) { FactoryGirl.create(:category, :slug => 'booooo') }
        before { get :show, :id => other_category.slug }

        it "should return zero creations" do
          assigns(:creations).should be_empty
        end
        it "should return the category" do
          assigns(:category).should eq(other_category)
        end
      end
    end
  end
end
