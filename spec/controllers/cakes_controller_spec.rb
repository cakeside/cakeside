require 'rails_helper'

describe CakesController do
  let(:user) { create(:user) }
  let(:cake) { create(:cake, user: user) }

  before(:each) do
    photo = 'spec/fixtures/images/example.png'
    cake.photos.create(image: photo)
  end

  describe "#index" do
    before { get :index }

    it "should display all creations" do
      expect(assigns(:creations)).to include(cake)
    end
  end

  describe "#show" do
    it "loads the cake" do
      get :show, id: cake.id
      expect(assigns(:creation)).to eql(cake)
    end

    it 'loads the selected image' do
      photo = cake.photos.first
      get :show, id: cake.id, photo_id: photo.id
      expect(assigns(:primary_image)).to eql(photo)
    end
  end
end
