require "rails_helper"

module Admin
  describe PhotosController do
    let(:admin) { create(:admin) }

    before :each do
      http_login(admin)
    end

    describe "#update" do
      let(:photo) { create(:photo) }

      it "re-processes the photo" do
        allow(ReProcessPhotoJob).to receive(:perform_later)

        put :update, id: photo.id

        expect(ReProcessPhotoJob).to have_received(:perform_later).with(photo)
      end
    end
  end
end
