require "rails_helper"

module Api
  module V1
    describe PhotosController do
      render_views

      let(:user) { create(:user) }
      let!(:cake) { create(:creation, user: user) }

      before :each do
        api_login(user)
      end

      describe "#index" do
        it "loads the cakes photos" do
          get :index, params: { cake_id: cake.id }, xhr: true
          expect(assigns(:photos)).to match_array(cake.photos)
        end
      end

      describe "#show" do
        let(:photo) { create(:photo, imageable: cake) }

        it "loads the photo" do
          get :show, params: { cake_id: cake.id, id: photo.id }, xhr: true
          expect(assigns(:photo)).to eql(photo)
        end
      end

      describe "#create" do
        let(:file) { fixture_file_upload("images/example.png", "image/png") }

        it "attaches a new photo to a cake" do
          allow(ProcessPhotoJob).to receive(:perform_later)

          post :create, params: { cake_id: cake.id, watermark: "watery", image: file }, xhr: true

          cake.reload
          expect(cake.photos.count).to eql(1)
          expect(cake.photos.first.watermark).to eql("watery")
          expect(cake.photos.first.image_processing).to be_truthy
          expect(ProcessPhotoJob).to have_received(:perform_later)
        end
      end
    end
  end
end
