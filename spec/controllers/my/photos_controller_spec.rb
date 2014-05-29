require 'spec_helper'

module My
  describe PhotosController do
    let(:user){ create(:user) }
    let(:cake){ create(:creation) }

    before(:each) do
      user.creations << cake
      http_login(user)
    end

    describe :post do
      let(:image) { Rack::Test::UploadedFile.new("spec/fixtures/images/gorilla.jpg", "image/jpeg") }

      before :each do
        post :create, :cake_id => cake.id, :photo => { :image => image }
      end

      it "returns http success" do
        response.should be_success
      end

      it "should upload a new photo" do
        assigns(:photo).should_not be_nil
        assigns(:photo).image.to_s.should include("gorilla.jpg")
      end
    end

    describe :delete do
      let!(:photo) { create(:photo) }

      before :each do
        cake.photos << photo
        cake.save!
        photo.update_attribute(:image_processing, nil)
        delete :destroy, :cake_id => cake.id, :id => photo.id
      end

      it "returns http success" do
        response.should be_success
      end

      it "should destroy the photo" do
        Photo.exists?(photo.id).should be_false
      end

      it "should respond with the proper json" do
        response.body.should ==
          {
          :files => [
            {
              :name => "example.png",
              :url => "/uploads/photo/image/#{photo.id}/example.png",
              :thumbnail_url => "/uploads/photo/image/#{photo.id}/thumb_example.png",
              :delete_url => photo.id,
              :delete_type => "DELETE"
            }]
        }.to_json
      end
    end
  end
end
