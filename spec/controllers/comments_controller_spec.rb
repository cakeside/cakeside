require 'spec_helper'

describe CommentsController do
  describe "when signed in" do
    let(:user) { FactoryGirl.create(:user) }

    context "when logged in" do
      before(:each) do
        http_login(user)
      end

      describe "POST create" do
        let(:creation) { FactoryGirl.create(:creation) }

        before(:each) do
          post :create, { :creation_id => creation.id, :comment => { :body => 'blah' } }
        end

        it "should display a message indicated that the comment was saved" do
          flash[:notice].should_not be_nil
        end

        it "should redirect to the creation#show page" do
          response.should redirect_to(creation)
        end

        it "should create a new comment" do
          creation.comment_threads.count.should == 1
        end

        it "should include the person who made the comment" do
          creation.comment_threads.first.user.should == user
        end
      end
    end
  end

  context "when not logged in" do
    let(:creation) { FactoryGirl.create(:creation) }

    before :each do
      post :create, { :creation_id => creation.id, :comment => { :body => 'hi' } }
    end

    #need to figure out how to get the devise helpers working
    it "should not let you comment" do
      response.should_not redirect_to(creation)
    end
  end
end
