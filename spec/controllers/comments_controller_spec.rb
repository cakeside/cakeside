require_relative '../../app/controllers/comments_controller'
require 'fakes'
require 'fakes-rspec'

describe CommentsController do
  let(:sut) { CommentsController.new }

  describe 'when commenting on a creation' do
    let(:flash_hash) { {} }
    let(:payload){ {:creation_id=>88, :comment => {:body => 'blah'}} }
    let(:command){ fake }

    before(:each) do
      sut.stub(:params).and_return(payload)
      sut.stub(:flash).and_return(flash_hash)
      sut.stub(:redirect_to).and_return(nil)
      sut.stub(:command_for).with(CommentOnCreationCommand).and_return(command)

      sut.create
    end

    it "should save the new comment" do
      command.should have_received(:run, payload)
    end
    it "should display a message indicated that the comment was saved" do
      flash_hash[:notice].should_not be_nil
    end
    it "should redirect to the creation#show page" do
     
    end
  end
end
