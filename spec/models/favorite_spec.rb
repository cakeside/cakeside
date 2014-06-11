require "rails_helper"

describe Favorite do
  context "#create" do
    let(:creation) { create(:creation, user: author) }
    let(:author) { create(:user) }
    let(:user) { create(:user) }

    it "creates a new activity" do
      creation.favorites.create(:user => user)
      creation.author.activities.count.should == 1
    end
  end
end
