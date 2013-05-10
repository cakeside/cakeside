require "spec_helper"

describe FavoritesController do
  context "when logged in" do
    let(:user) { FactoryGirl.create(:user) }

    before { http_login(user) }

    context "when loading all the favorites for a creation" do
      let(:creation) { FactoryGirl.create(:creation) }
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
  end

end
