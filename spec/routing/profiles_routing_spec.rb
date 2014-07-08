require 'rails_helper'

describe ProfilesController do
  describe "routing" do
    it "routes to index" do
      expect(get: '/profiles/').to route_to("profiles#index")
    end

    it "routes to #show" do
      expect(get: "/profiles/1").to route_to("profiles#show", id: "1")
    end
  end
end
