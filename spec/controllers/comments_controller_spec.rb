require "spec_helper"

describe CommentsController do
  context "#create" do
    let(:creation) { create(:creation) }
    let(:user) { create(:user) }

    before :each do
      http_login(user)
    end

    it "creates a new comment" do
      post :create, id: 1207743539, url: "http://localhost:3000/creations/#{creation.to_param}", comment: { id: 1207743539, text: 'very nice' }
      comment = Comment.last
      comment.disqus_id.should == 1207743539
      comment.creation.should == creation
      comment.text.should == 'very nice'
    end
  end
end
