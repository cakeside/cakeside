require 'rails_helper'

describe PhotosController do
  let(:cake){ create(:cake) }

  describe "#index" do
    before :each do
      get :index, cake_id: cake.id
    end

    it "loads the cake" do
      expect(assigns(:creation)).to eql(cake)
    end

    it "loads the photos" do
      expect(assigns(:photos)).to match_array(cake.photos)
    end
  end

  describe "#show" do
    let(:photo) { create(:photo) }

    before :each do
      cake.photos.push(photo)
      get :show, cake_id: cake.id, id: photo.id
    end

    it "loads the cake" do
      expect(assigns(:creation)).to eql(cake)
    end

    it "loads the photo" do
      expect(assigns(:photo)).to eql(photo)
    end
  end
end
