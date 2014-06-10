require "spec_helper"

describe My::CakesController do
  context "when logged in" do
    let(:user){ create(:user) }
    before { http_login(user) }

    describe "#index" do
      let!(:my_creation) { create(:creation) }
      let!(:other_creation) { create(:creation) }

      before :each do
        user.creations << my_creation
        get :index
      end

      it "should return all of my creations" do
        assigns(:creations).should include(my_creation)
      end

      it "should not return any other creations" do
        assigns(:creations).should_not include(other_creation)
      end
    end
  end

  context "when not logged in" do
    it "redirects you to the home page" do
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end
end

