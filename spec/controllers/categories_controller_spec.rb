require 'spec_helper'

describe CategoriesController do

  before(:each) do
    @creations = []
    @category = FactoryGirl.create(:category, :creations => @creations)
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
end
