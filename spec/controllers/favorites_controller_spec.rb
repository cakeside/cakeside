require "rails_helper"

describe FavoritesController do
  context "when logged in" do
    let(:user) { create(:user) }
    let(:cake) { create(:cake) }

    before { http_login(user) }

    context "when adding a cake to your favorites" do
      before :each do
        post :create, cake_id: cake.id
      end

      it "should add the cake to the logged in users favorites" do
        expect(user.reload.favorites.count).to eql(1)
      end

      it "should redirect to the cake detail page" do
        expect(response).to redirect_to(cake_path(cake))
      end

      it "should include a friendly flash message" do
        expect(flash[:notice]).to_not be_nil
      end
    end
  end
end
