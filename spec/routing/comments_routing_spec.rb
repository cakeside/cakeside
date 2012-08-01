require "spec_helper"

describe CommentsController do
  describe "routing" do
    it "routes to index" do
      get('/creations/1/comments').should route_to('comments#index', :creation_id => "1")
    end
    it "routes to new" do
      get('/creations/1/comments/new').should route_to("comments#new", :creation_id => "1")
    end
    it "routes to create" do
      post('/creations/1/comments').should route_to("comments#create", :creation_id => "1")
    end
  end
end
