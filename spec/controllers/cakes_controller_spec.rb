require 'rails_helper'

describe CakesController do
  let(:user) { create(:user) }

  before :each do
    #photo = 'spec/fixtures/images/example.png'
    #cake.photos.create(image: photo)
  end

  describe "#index" do
    let!(:cakes) { create(:category, slug: "cakes") }
    let!(:cookies) { create(:category, slug: "cookies") }

    it "returns all published cakes" do
      cake = create(:published_cake, category: cakes)
      cookie = create(:published_cake, category: cookies)
      unpublished_cake = create(:cake, category: cakes)
      get :index
      expect(assigns(:cakes)).to match_array([cake, cookie])
    end

    it "returns all cakes in the category" do
      cookie = create(:published_cake, name: "cookie", category: cookies)
      get :index, category: cookie.category.slug
      expect(assigns(:cakes)).to match_array([cookie])
    end

    it "returns all cakes matching the search query" do
      cake = create(:published_cake, name: "cake", category: cakes)
      get :index, q: cake.name[0..2]
      expect(assigns(:cakes)).to match_array([cake])
    end

    it "returns all cakes tagged with the tag" do
      cake = create(:published_cake, name: "cake", category: cakes)
      cake.tag_list = "cakes"
      cake.save!

      get :index, tags: "cakes"
      expect(assigns(:cakes)).to match_array([cake])
    end

    describe "sorting" do
      let!(:old_cake) { create(:published_cake, name: 'old', created_at: 2.days.ago) }
      let!(:new_cake) { create(:published_cake, name: 'new', created_at: 1.day.ago) }

      it 'returns oldest cakes first' do
        get :index, sort: "oldest"
        expect(assigns(:cakes).to_a).to eql([ old_cake, new_cake ])
      end

      it 'returns newest cakes first' do
        get :index, sort: "newest"
        expect(assigns(:cakes).to_a).to eql([ new_cake, old_cake ])
      end
    end
  end

  describe "#show" do
    let(:cake) { create(:cake, user: user) }
    let(:photo) { create(:photo, imageable: cake) }

    it "loads the cake" do
      get :show, id: cake.id
      expect(assigns(:creation)).to eql(cake)
    end

    it 'loads the selected image' do
      get :show, id: cake.id, photo_id: photo.id
      expect(assigns(:primary_image)).to eql(photo)
    end
  end
end
