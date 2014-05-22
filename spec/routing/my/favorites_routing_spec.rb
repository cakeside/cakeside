require 'spec_helper'

describe My::FavoritesController do
  describe "routing" do
    it "routes to my favorites" do
      get("/my/favorites").should route_to("my/favorites#index")
    end
  end
end
