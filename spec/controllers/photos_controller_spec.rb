require 'spec_helper'

describe PhotosController do
  let(:user){ create(:user) }
  let(:creation){ create(:creation) }

  before(:each) do
    user.creations << creation
    http_login(user)
  end

  describe :post do
    let(:image) { Rack::Test::UploadedFile.new("spec/fixtures/images/gorilla.jpg", "image/jpeg") }

    before :each do
      post :create, :creation_id => creation.id, :photo => { :image => image }
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
      creation.photos << photo
      creation.save!
      delete :destroy, :creation_id => creation.id, :id => photo.id
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
           :name=>"example.png",
           :size=>359791,
           :url=>"/uploads/photo/image/#{photo.id}/example.png",
           :thumbnail_url=>"/uploads/photo/image/#{photo.id}/thumb_example.png",
           :delete_url=>photo.id,
           :delete_type=>"DELETE"
        }]
      }.to_json
    end
  end
end
