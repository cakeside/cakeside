require "rails_helper"

describe FavoritesController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cakes/1/favorites").to route_to(controller: "favorites", action: "index", cake_id: "1")
    end

    it "routes to #create" do
      expect(post: "/cakes/1/favorites").to route_to(controller: "favorites", action: "create", cake_id: "1")
    end
  end
end
