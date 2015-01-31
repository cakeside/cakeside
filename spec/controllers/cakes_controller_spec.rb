require 'rails_helper'

describe CakesController do
  let(:user) { create(:user) }

  before(:each) do
    photo = 'spec/fixtures/images/example.png'
    cake.photos.create(image: photo)
  end

  describe "#index" do
    let!(:cakes) { create(:category, slug: "cakes") }
    let!(:cookies) { create(:category, slug: "cookies") }
    let!(:cake) { create(:published_cake, name: "cake", category: cakes) }
    let!(:cookie) do
      create(:published_cake, name: "cookie", category: cookies)
    end

    let!(:unpublished_cake) do
      create(:cake, name: "unpublished", category: cakes)
    end

    it "returns all published cakes" do
      get :index
      expect(assigns(:cakes)).to match_array([cake, cookie])
    end

    it "returns all cakes in the category" do
      get :index, category: cookie.category.slug
      expect(assigns(:cakes)).to match_array([cookie])
    end

    it "returns all cakes matching the search query" do
      get :index, q: cake.name[0..2]
      expect(assigns(:cakes)).to match_array([cake])
    end

    it "returns all cakes tagged with the tag" do
      cake.tag_list = "cakes"
      cake.save!

      get :index, tags: "cakes"
      expect(assigns(:cakes)).to match_array([cake])
    end
  end

  describe "#show" do
    let(:cake) { create(:cake, user: user) }

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
