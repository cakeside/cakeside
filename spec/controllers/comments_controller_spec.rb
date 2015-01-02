require "rails_helper"

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
      expect(comment.disqus_id).to eql(1207743539)
      expect(comment.creation).to eql(creation)
      expect(comment.text).to eql('very nice')
    end
  end
end
