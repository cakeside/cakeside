require "spec_helper"

describe FavoritesController do
  describe "routing" do

    it "routes to #index" do
      get("/creations/1/favorites").should route_to("favorites#index")
    end

    it "routes to #create" do
      post("/creations/1/favorites").should route_to("favorites#create")
    end
  end
end
