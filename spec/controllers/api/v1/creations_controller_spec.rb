require "rails_helper"

describe Api::V1::CreationsController do
  context "when signed in" do
    let(:creation) { create(:creation) }
    let(:user) { create(:user) }
    let(:repository) { double }

    before :each do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.authentication_token)
      CreationRepository.any_instance.stub(:visible_creations).and_return([creation])

      get :index, :format => :json
    end

    it "should return all viewable creations" do
      assigns(:creations).should include(creation)
    end
  end
end
