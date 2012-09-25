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

    before(:each) do
      get :show, :id => @category.slug
    end

    it "assigns the requested category as @category" do
      assigns(:category).should eq(@category)
    end

    it "should return all creations that are in the category" do
      assigns(:creations).should eq(@creations)
    end
  end

  context "when there is NO category that matches the slug" do
    before(:each) do
      @other_category = FactoryGirl.create(:category, :slug => 'booooo')
      get :show, :id => @other_category.slug
    end
    it "should return zero creations" do
      assigns(:creations).should be_empty
    end
    it "should return the category" do
      assigns(:category).should eq(@other_category)
    end
  end

  context "when there is a category that matches the slug" do
    context "when there are creations in the category" do

    end
    context "when there are no creations in the category" do

    end
  end
end
