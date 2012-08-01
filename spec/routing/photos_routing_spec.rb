require "spec_helper"
describe PhotosController do
  describe "routing" do
    it "should route to create" do
      post('creations/1/photos').should 
        route_to(:controller => "photos", :action => "create", :creation_id => 1, :method => "POST")
    end
    it "should route to delete" do
      delete('creations/1/photos').should 
        route_to(:controller => "photos", :action => "destroy", :creation_id => 1, :method => "DELETE")
    end
  end
end
describe FavoritesController do
  describe "routing" do
    it "should route to create" do
      get('creations/1/favorites').should 
        route_to(:controller => "favorites", :action => "index", :creation_id => 1, :method => "GET")
    end
    it "should route to delete" do
      post('creations/1/favorites').should 
        route_to(:controller => "favorites", :action => "create", :creation_id => 1, :method => "POST")
    end
  end
end
