require 'rails_helper'

module Api
  module V1
    describe PhotosController do
      render_views

      let(:user) { create(:user) }
      let!(:cake) { create(:creation, user: user) }

      before :each do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(user.authentication_token)
      end

      describe "#index" do
        it 'loads the cakes photos' do
          xhr :get, :index, cake_id: cake.id
          expect(assigns(:photos)).to match_array(cake.photos)
        end
      end

      describe "#show" do
        let(:photo) { create(:photo, imageable: cake) }

        it 'loads the photo' do
          xhr :get, :show, cake_id: cake.id, id: photo.id
          expect(assigns(:photo)).to eql(photo)
        end
      end
    end
  end
end
