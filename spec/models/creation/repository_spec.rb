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
end
