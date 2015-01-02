require 'rails_helper'

describe My::FavoritesController do
  it "routes to my favorites" do
    expect(get("/my/favorites")).to route_to("my/favorites#index")
  end
end
