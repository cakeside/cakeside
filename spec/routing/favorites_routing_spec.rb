require "rails_helper"

describe FavoritesController do
  describe "routing" do

    it "routes to #index" do
      { get: "/creations/1/favorites" }.should route_to({
        :controller => "favorites",
        :action => "index",
        :creation_id => "1"
      })
    end

    it "routes to #create" do
      { post: "/creations/1/favorites" }.should route_to({
        :controller => "favorites",
        :action => "create",
        :creation_id => "1"
      })
    end
  end
end
