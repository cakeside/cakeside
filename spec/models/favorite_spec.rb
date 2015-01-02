require "rails_helper"

describe Favorite do
  context "#create" do
    let(:creation) { create(:creation, user: author) }
    let(:author) { create(:user) }
    let(:user) { create(:user) }

    it "creates a new activity" do
      user.favorites.create(creation: creation)
      expect(creation.author.activities.count).to eql(1)
    end
  end
end
