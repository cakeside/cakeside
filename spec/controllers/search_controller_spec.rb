require 'rails_helper'

describe SearchController do
  describe "GET 'index'" do
    context "when no search query is given" do
      before { get :index }

      it "should redirect you to the home page" do
        expect(response).to redirect_to(root_url)
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

      it "returns a successful response" do
        expect(response).to be_success
      end

      it "returns all creations that have a matching name" do
        expect(assigns(:creations)).to include(cake)
      end

      it "does not include cakes that do not match" do
        expect(assigns(:creations)).to_not include(donut)
      end

      it "returns all makers that match" do
        expect(assigns(:members)).to include(user)
      end

      it "does not include makers with names that do not match" do
        expect(assigns(:members)).to_not include(bob)
      end

      it "returns all tutorials that match" do
        expect(assigns(:tutorials)).to include(tutorial)
      end

      it "does not return tutorials that do not match" do
        expect(assigns(:tutorials)).to_not include(other_tutorial)
      end
    end
  end
end
