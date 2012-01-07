require "spec_helper"

describe LikesController do
  describe "routing" do

    it "routes to #index" do
      get("/creations/1/likes").should route_to("likes#index")
    end

    it "routes to #create" do
      post("/creations/1/likes").should route_to("likes#create")
    end
  end
end
