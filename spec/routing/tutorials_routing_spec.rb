require "rails_helper"

describe TutorialsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/tutorials").to route_to("tutorials#index")
    end

    it "routes to #show" do
      expect(get: "/tutorials/1").to route_to("tutorials#show", :id => "1")
    end
  end
end
