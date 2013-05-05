require 'spec_helper'

describe SearchController do
  describe "GET 'index'" do
    let!(:user) { FactoryGirl.create(:user, :name => 'cake') }
    let!(:bob) { FactoryGirl.create(:user, :name => 'bob') }
    let!(:cake) { FactoryGirl.create(:creation, :name => 'cake') }
    let!(:donut) { FactoryGirl.create(:creation, :name => 'donut') }

    before { get :index, { :q => 'cake' } }

    it "should be successful" do
      response.should be_success
    end

    it "should return all creations that have a matching name" do
      assigns(:creations).should include(cake)
    end

    it "should not include cakes that do not match" do
      assigns(:creations).should_not include(donut)
    end

    it "should return all makers that match" do
      assigns(:members).should include(user)
    end

    it "should not include makers with names that do not match" do
      assigns(:members).should_not include(bob)
    end
  end
end
