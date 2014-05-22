require "spec_helper"

describe My::FavoritesController do
  describe :index do
    let(:user) { create(:user) }
    let(:favorite_cake) { create(:creation) }

    before :each do
      http_login(user)
      user.add_favorite(favorite_cake)
      get :index
    end

    it "loads all my favorite cakes" do
      assigns(:creations).should include(favorite_cake)
    end
  end
end
