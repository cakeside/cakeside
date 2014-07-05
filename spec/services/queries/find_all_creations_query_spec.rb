require "rails_helper"

describe FindAllCreationsQuery do
  let(:sut) { FindAllCreationsQuery.new }
  let(:results) { sut.fetch({}) }

  let!(:cake_with_a_photo) { create(:creation) }
  let!(:cake_without_a_photo) { create(:creation, photos: []) }

  before :each do
    cake_with_a_photo.photos << create(:photo)
    cake_with_a_photo.photos.first.update_attribute(:image_processing, nil)
  end

  it "returns all creations with at least one photo" do
    results.should include(cake_with_a_photo)
  end

  it "ignores cakes without a photo" do
    results.should_not include(cake_without_a_photo)
  end
end
