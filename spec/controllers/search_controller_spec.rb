require 'spec_helper'

describe SearchController do
  describe "GET 'index'" do
    context "when no search query is given" do
      before { get :index }

      it "should redirect you to the home page" do
        response.should redirect_to(root_url)
      end
    end
    context "when a valid search query is given" do
      let!(:user) { create(:user, :name => 'cake') }
      let!(:bob) { create(:user, :name => 'bob') }
      let!(:cake) { create(:creation, :name => 'cake') }
      let!(:donut) { create(:creation, :name => 'donut') }
      let!(:tutorial) { create(:tutorial, :description => 'cake') }
      let!(:other_tutorial) { create(:tutorial, :description => 'donut') }

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

      it "should return all tutorials that match" do
        assigns(:tutorials).should include(tutorial)
      end

      it "should not return tutorials that do not match" do
        assigns(:tutorials).should_not include(other_tutorial)
      end
    end
  end
end
