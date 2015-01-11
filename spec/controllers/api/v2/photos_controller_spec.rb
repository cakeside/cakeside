require 'rails_helper'

module Api
  module V2
    describe PhotosController do
      describe "#index" do
        let!(:processed_photo) { create(:photo, image_processing: nil) }
        let!(:unprocessed_photo) { create(:photo, image_processing: true) }

        it 'loads all processed photos' do
          xhr :get, :index
          expect(assigns(:photos)).to match_array([processed_photo])
        end
      end

      describe "#show" do
        let!(:other_photo) { create(:photo) }
        let!(:photo) { create(:photo) }

        it 'loads the specified photo' do
          xhr :get, :show, id: photo.id
          expect(assigns(:photo)).to eql(photo)
        end
      end
    end
  end
end
