require "rails_helper"

describe CreationRepository do
  describe "#visible_creations" do
    let!(:user){ create(:user) }
    let!(:published_cake){ create(:creation, user: user) }
    let!(:restricted_cake){ create(:creation, user: user, is_restricted: true) }

    before :each do
      published_cake.photos.create(image: 'example.png', image_processing: nil)
    end

    let(:results) { subject.visible_creations }

    it "returns cakes that are not restricted" do
      expect(results).to_not include(restricted_cake)
    end

    it "returns cakes that do not have photos that are processing" do
      expect(results.count).to eql(1)
      expect(results).to include(published_cake)
    end
  end
end
