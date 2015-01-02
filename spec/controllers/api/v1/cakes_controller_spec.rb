require "rails_helper"

describe Api::V1::CakesController do
  context "when signed in" do
    let(:user) { create(:user) }
    let!(:my_cake) { create(:creation) }
    let!(:other_cake) { create(:creation) }

    before :each do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.authentication_token)
      user.creations << my_cake
      get :index, :format => :json
    end

    it "should return all of my cakes" do
      expect(assigns(:cakes)).to match_array([my_cake])
    end

    it "should not return any other cakes" do
      expect(assigns(:cakes)).to_not include(other_cake)
    end
  end
end
