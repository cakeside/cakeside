require_relative '../../app/controllers/comments_controller'
require 'fakes'
require 'fakes-rspec'

describe CommentsController do
  let(:sut) { CommentsController.new }

  describe 'when commenting on a creation' do
    let(:comment) { fake }

    it "should save the new comment" do
      comment.should have_received(:save)
    end
    it "should display a message indicated that the comment was saved" do
      @flash_hash[:notice].should_not be_nil
    end
    it "should not display an errors" do
      @flash_hash[:error].should be_nil
    end
    it "should redirect to the creation#show page" do
     
    end
    before(:each) do
      creation = fake
      user = fake
      @flash_hash = {}

      comment.stub(:save).and_return(true)
      user.stub(:id).and_return(8)
      sut.stub(:params).and_return({:creation_id=>88, :comment => {:body => 'blah'}})
      sut.stub(:current_user).and_return(user)
      sut.stub(:flash).and_return(@flash_hash)
      sut.stub(:redirect_to).and_return(nil)
      sut.stub(:creation_path).with(creation).and_return('url')
      Creation.stub(:find).with(88).and_return(creation)
      Comment.stub(:build_from).with(creation, 8, 'blah').and_return(comment)

      sut.create
    end
  end
end
