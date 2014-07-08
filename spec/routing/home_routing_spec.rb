require 'rails_helper'

describe HomeController do
  describe "routing" do
    it "routes to about us" do
      expect(get: 'about_us').to route_to("home#about_us")
    end

    it "routes to why" do
      expect(get: 'why_cakeside').to route_to("home#why_cakeside")
    end
  end
end
