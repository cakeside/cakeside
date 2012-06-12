require_relative '../../app/models/comment.rb'

describe Comment do
  describe "when creating a new comment" do
    it "should return a comment with the correct body" do
      @result.body.should == "blah"
    end
    it "should track the user id" do
      @result.user_id.should == user.id
    end
    before(:each) do
      @result = Comment.create_for(user, creation, 'blah')
    end

    let(:user) { fake }
    let(:creation) { Creation.new }
  end
end
