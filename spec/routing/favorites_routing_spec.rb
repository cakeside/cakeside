require "rails_helper"

describe FavoritesController do
  it "routes to #create" do
    expect(post: "/cakes/1/favorites").to route_to(controller: "favorites", action: "create", cake_id: "1")
  end
end
