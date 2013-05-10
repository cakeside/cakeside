require "spec_helper"

describe FavoritesController do
  context "when logged in" do
    let(:user) { FactoryGirl.create(:user) }
    let(:creation) { FactoryGirl.create(:creation) }

    before { http_login(user) }

    context "when loading all the favorites for a cake" do
      let(:favorite) { FactoryGirl.create(:favorite, :creation => creation, :user => user) }

      before :each do
        creation.favorites << favorite
        creation.save!
        get :index, :creation_id => creation.id
      end

      it "should return them all" do
        assigns(:favorites).should include favorite
      end
    end

    context "when adding a cake to your favorites" do
      before :each do
        post :create, :creation_id => creation.id
      end

      it "should add the cake to the logged in users favorites" do
        user.reload.favorites.count == 1
      end

      it "should redirect to the cake detail page" do
        response.should redirect_to(creation)
      end

      it "should include a friendly flash message" do
        flash[:notice].should_not be_nil
      end
    end
  end

end
