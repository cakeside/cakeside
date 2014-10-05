require "rails_helper"

describe CreationsController do
  describe "routing" do
    it "is the root of the website" do
      expect(get: '/').to route_to("creations#index")
    end

    it "recognizes and generates #index" do
      expect(get: 'cakes').to route_to(controller: 'creations', action: 'index')
    end

    it "recognizes and generates #show" do
      expect(get: "/cakes/1").to route_to(controller: "creations", action: "show", id: "1")
    end

    it "routes to the newest cakes" do
      expect(get: '/cakes/newest').to route_to(controller: "creations", action: "index", sort: 'newest')
    end

    it "routes to the oldest cakes" do
      expect(get: '/cakes/oldest').to route_to(controller: "creations", action: "index", sort: 'oldest')
    end
  end
end
