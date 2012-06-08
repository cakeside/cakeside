require_relative '../../app/controllers/comments_controller'
require 'fakes'
require 'fakes-rspec'

describe CommentsController do
  let(:sut) { CommentsController.new }
  describe 'when commenting on a creation' do
    let(:comment) { fake }

    it "should save the new comment" do
      comment.should have_receieved(:save)
    end
    before(:each) do
      Comment.stub(:build_from).and_return(comment)
      sut.create
    end
  end
end
