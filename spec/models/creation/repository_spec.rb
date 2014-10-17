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

  describe "#visible_creations" do
    let!(:user){ create(:user) }
    let!(:published_cake){ create(:creation, user: user) }

    before :each do
      published_cake.photos.create(image: 'example.png', image_processing: nil)
    end

    let(:results) { subject.visible_creations }

    it "returns cakes that do not have photos that are processing" do
      expect(results.count).to eql(1)
      expect(results).to include(published_cake)
    end
  end

  describe "#search" do
    let(:cake) { create(:creation, name: 'Cake') }
    let(:cup_cake) { create(:creation, name: 'Cup Cake') }

    it "returns cakes with a matching name" do
      results = subject.search('cake')
      expect(results).to include(cake)
      expect(results).to_not include(cup_cake)
    end
  end
end
