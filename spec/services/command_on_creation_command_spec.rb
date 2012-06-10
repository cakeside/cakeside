describe CommentOnCreationCommand do
  let(:sut) { CommentOnCreationCommand.new(user) }
  let(:user) { fake }
  describe "when run" do
    let(:creation) { fake }
    let(:comment) { fake }
    it "should add the new comment to the creation" do
      user.should have_received(:comment_on, creation, "wow")
    end
    it "should save the comment" do
      comment.should have_received(:save)
    end
    before(:each) do
      params = {:creation_id => 8, :comment => { :body => "wow" }}
      Creation.stub(:find).with(8).and_return(creation)
      user.stub(:comment_on).with(creation, "wow").and_return(comment)
      sut.run(params)
    end
  end
end
