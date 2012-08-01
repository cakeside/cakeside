require 'spec_helper'

describe HomeController do
  describe "routing" do
    it "routes to about us" do
      get('about_us').should route_to("home#about_us")
    end
    it "routes to why" do
      get('why_cakeside').should route_to("home#why_cakeside")
    end
  end
end
