require 'rails_helper'

describe Creation::Repository do
  describe "#tagged" do
    let(:user) { create(:user) }
    let(:tag) { "cake" }
    let(:tagged_cake) { create(:creation, photos_count: 1) }
    let(:untagged_cake) { create(:creation) }

    before :each do
      user.tag(tagged_cake, with: tag, on: :tags)
    end

    it "returns each cake that is tagged" do
      expect(subject.tagged(tag)).to include(tagged_cake)
    end

    it "does not return cakes that are not tagged" do
      expect(subject.tagged(tag)).to_not include(untagged_cake)
    end
  end

  describe "#published" do
    let!(:user){ create(:user) }
    let!(:published_cake){ create(:creation, user: user) }

    before :each do
      published_cake.photos.create(image: 'example.png', image_processing: nil)
    end

    let(:results) { subject.published }

    it "returns cakes that do not have photos that are processing" do
      expect(results.count).to eql(1)
      expect(results).to match_array([published_cake])
    end
  end

  describe "#search" do
    let(:cake) { create(:creation, name: 'Cake') }
    let(:cup_cake) { create(:creation, name: 'Cup Cake') }

    it "returns cakes with a matching name" do
      expect(subject.search('cake')).to match_array([cake])
    end
  end

  context "#search_with" do
    let(:cake_category) { create(:category) }
    let!(:cake) { create(:cake, category: cake_category) }
    let!(:cookie) { create(:cake) }

    before :each do
      cake.photos << create(:photo)
      cookie.photos << create(:photo)
    end

    it 'returns all cakes in a specific category' do
      cakes = subject.search_with(category: cake_category.slug)
      expect(cakes).to match_array([cake])
    end

    it 'returns all cakes that match the search query' do
      cakes = subject.search_with(q: cake.name[0..6])
      expect(cakes).to match_array([cake])
    end
  end
end
