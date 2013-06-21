require 'spec_helper'

describe CategoriesController do
  before(:each) do
    @creation = FactoryGirl.create(:creation)
    @category = FactoryGirl.create(:category, :creations => [@creation])
  end

  describe "GET show" do
    context "when there is a category that matches the slug" do
      context "when there are creations in the category" do
        before { get :show, :slug => @category.slug }

        it "should return the creations in the category" do
          assigns(:creations).should == [@creation]
        end
        it "should return the category" do
          assigns(:category).should == @category
        end
      end

      context "when there are no creations in the category" do
        let(:other_category) { FactoryGirl.create(:category, :slug => 'booooo') }
        before { get :show, :slug => other_category.to_param }

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
