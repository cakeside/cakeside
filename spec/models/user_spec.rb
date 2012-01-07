require 'spec_helper'

describe User do
  describe "when a user already likes a creation" do 
    it "should not let the user like it again" do
      # creation = Creation.new
      creation = FactoryGirl.create(:creation)
      # user = User.create!
      user = FactoryGirl.create(:user)
      user.like(creation)
      user.like(creation)

      # creation.likes.each do |like|
      #   puts like.user.id
      # end
      creation.likes.length.should eq(1)
    end
  end
end
