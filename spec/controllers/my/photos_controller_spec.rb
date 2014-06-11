require 'rails_helper'

module My
  describe PhotosController do
    let(:user){ create(:user) }
    let(:cake){ create(:creation) }

    before(:each) do
      user.creations << cake
      http_login(user)
    end

    describe "#create" do
      let(:image) { Rack::Test::UploadedFile.new("spec/fixtures/images/gorilla.jpg", "image/jpeg") }

      before :each do
        xhr :post, :create, cake_id: cake.id, photo: { image: image }
      end

      it "returns http success" do
        response.should be_success
      end

      it "should upload a new photo" do
        json = JSON.parse(response.body)
        json["files"].first["name"].should_not be_nil
        json["files"].first["url"].should_not be_nil
        json["files"].first["thumbnail_url"].should_not be_nil
        json["files"].first["delete_url"].should_not be_nil
        json["files"].first["delete_type"].should == "DELETE"
      end
    end

    describe "#delete" do
      let!(:photo) { create(:photo, creation_id: cake.id, image_processing: nil) }
      let(:asset_host) { ENV['ASSET_HOST'] }

      before :each do
        delete :destroy, cake_id: cake.id, id: photo.id
      end

      it "returns http success" do
        response.should be_success
      end

      it "should destroy the photo" do
        Photo.exists?(photo.id).should be_falsey
      end

      it "should respond with the proper json" do
        response.body.should ==
        {
          files: [{
              name: "example.png",
              url: "#{asset_host}/uploads/photo/image/#{photo.id}/large_example.png",
              thumbnail_url: "#{asset_host}/uploads/photo/image/#{photo.id}/thumb_example.png",
              delete_url: photo.id,
              delete_type: "DELETE"
            }]
        }.to_json
      end
    end
  end
end
