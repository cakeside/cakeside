require "rails_helper"

describe FavoritesController do
  context "when logged in" do
    let(:user) { create(:user) }
    let(:creation) { create(:creation) }

    before { http_login(user) }

    context "when loading all the favorites for a cake" do
      let(:favorite) { create(:favorite, :creation => creation, :user => user) }

      before :each do
        creation.favorites << favorite
        creation.save!
        get :index, creation_id: creation.id
      end

      it "should return them all" do
        expect(assigns(:favorites)).to include(favorite)
      end
    end

    context "when adding a cake to your favorites" do
      before :each do
        post :create, creation_id: creation.id
      end

      it "should add the cake to the logged in users favorites" do
        expect(user.reload.favorites.count).to eql(1)
      end

      it "should redirect to the cake detail page" do
        expect(response).to redirect_to(creation)
      end

      it "should include a friendly flash message" do
        expect(flash[:notice]).to_not be_nil
      end
    end
  end
end
