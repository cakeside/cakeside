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
