require "rails_helper"

describe AllCakesQuery do
  subject { AllCakesQuery.new }

  context "with no filters" do
    let!(:cake_with_a_photo) { create(:cake) }
    let!(:cake_without_a_photo) { create(:cake, photos: []) }

    before :each do
      cake_with_a_photo.photos << create(:photo)
    end

    it "returns all cakes with at least one photo" do
      results = subject.fetch({})
      expect(results).to include(cake_with_a_photo)
    end

    it "ignores cakes without a photo" do
      results = subject.fetch({})
      expect(results).to_not include(cake_without_a_photo)
    end
  end

  context "with filters" do
    let(:cake_category) { create(:category) }
    let!(:cake) { create(:cake, category: cake_category) }
    let!(:cookie) { create(:cake) }

    before :each do
      cake.photos << create(:photo)
      cookie.photos << create(:photo)
    end

    it 'returns all cakes in a specific category' do
      cakes = subject.fetch(category: cake_category.slug)
      expect(cakes).to include(cake)
      expect(cakes).to_not include(cookie)
    end
  end
end
