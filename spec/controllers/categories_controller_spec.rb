require 'spec_helper'

describe CategoriesController do

  before(:each) do
    @creation = FactoryGirl.create(:creation)
    @creations = [@creation]
    @category = FactoryGirl.create(:category, :creations => @creations)
    @creation.category_ids = [@category.id]
    @creation.save
  end

  describe "GET show" do
    context "when there is NO category that matches the slug" do
      it "should return nothing" do
        assigns(:category).should be_nil
        assigns(:creations).should be_nil
      end
    end
    context "when there is a category that matches the slug" do
      context "when there are creations in the category" do
        before(:each) do
          get :show, :id => @category.slug
        end
        it "should return the creations in the category" do
          assigns(:creations).should eq(@creations)
        end
        it "should return the category" do
          assigns(:category).should eq(@category)
        end
      end
      context "when there are no creations in the category" do
        let(:other_category) { FactoryGirl.create(:category, :slug => 'booooo') }
        before(:each) do
          get :show, :id => other_category.slug
        end
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
