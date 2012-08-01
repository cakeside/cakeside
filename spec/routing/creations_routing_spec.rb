require "spec_helper"

describe CreationsController do
  describe "routing" do
    it "is the root of the website" do
      get('/').should route_to("creations#index")
    end

    it "recognizes and generates #index" do
      { :get => "/creations" }.should route_to(:controller => "creations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/creations/new" }.should route_to(:controller => "creations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/creations/1" }.should route_to(:controller => "creations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/creations/1/edit" }.should route_to(:controller => "creations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/creations" }.should route_to(:controller => "creations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/creations/1" }.should route_to(:controller => "creations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/creations/1" }.should route_to(:controller => "creations", :action => "destroy", :id => "1")
    end

    it "routes to crop" do
      get('/creations/crop/1').should route_to("creations#crop", :id => "1", :method => "GET")
    end
    it "routes to crop update" do
      post('/creations/crop_update/1').should route_to("creations#crop_update", :id => "1", :method => "POST")
    end
  end
end
