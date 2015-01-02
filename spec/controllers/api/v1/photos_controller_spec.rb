require 'rails_helper'

module Api
  module V1
    describe PhotosController do
      let(:user) { create(:user) }
      let!(:cake) { create(:creation) }

      describe "#index" do
        before :each do
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.authentication_token)
          user.creations << cake
        end

        it 'loads the cakes photos' do
          xhr :get, :index, cake_id: cake.id
          expect(assigns(:photos)).to match_array(cake.photos)
        end
      end
    end
  end
end
