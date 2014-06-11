require 'rails_helper'

describe PhotosController do
  let(:creation){ create(:creation) }

  describe "#index" do
    before :each do
      get :index, creation_id: creation.id
    end

    it "loads the creation" do
      assigns(:creation).should == creation
    end

    it "loads the photos" do
      assigns(:photos).should == creation.photos
    end
  end

  describe "#show" do
    let(:photo) { create(:photo) }

    before :each do
      creation.photos.push(photo)
      get :show, creation_id: creation.id, id: photo.id
    end

    it "loads the cake" do
      assigns(:creation).should == creation
    end

    it "loads the photo" do
      assigns(:photo).should == photo
    end
  end
end
