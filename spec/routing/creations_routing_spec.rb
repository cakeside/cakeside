require "rails_helper"

describe CreationsController do
  describe "routing" do
    it "is the root of the website" do
      { get: '/' }.should route_to("creations#index")
    end

    it "recognizes and generates #index" do
      { :get => "/creations" }.should route_to(:controller => "creations", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/creations/1" }.should route_to(:controller => "creations", :action => "show", :id => "1")
    end
  end
end
