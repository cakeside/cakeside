require "spec_helper"

describe AuthenticationsController do
  describe "routing" do
    it "routes to #show" do
      get("/authentications/").should route_to("authentications#index", :method => 'GET')
    end
  end
end
