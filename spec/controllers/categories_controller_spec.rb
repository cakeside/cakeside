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

  end

  context "when there is a category that matches the slug" do
    context "when there are creations in the category" do

    end
    context "when there are no creations in the category" do

    end
  end
end
