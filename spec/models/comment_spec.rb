require "rails_helper"

describe Comment do
  describe "#create" do
    let(:creation) { create(:creation) }
    let(:user) { creation.user }

    it "creates a new activity" do
      comment = Comment.create(user: user, creation: creation)
      comment.activities.count.should == 1
    end
  end
end
