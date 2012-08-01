require 'spec_helper'
describe ProfilesController do
  describe "routing" do
    it "routes to index" do
      get('/profiles/').should route_to("profiles#index", :method => "GET")
    end
    it "routes to #show" do
      get("/profiles/1").should route_to("profiles#show", :id => "1", :method => 'GET')
    end
    it "routes to my profile" do
      get("mine").should route_to("profiles#mine", :method => 'GET')
    end
    it "routes to my favorites" do
      get("favorites").should route_to("profiles#favorites", :method => "GET")
    end
  end
end
