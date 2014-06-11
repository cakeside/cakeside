require "rails_helper"

describe CategoriesController do
  describe "routing" do
    it "routes to #show" do
      get("/categories/fondant").should route_to({:slug => "fondant", :controller => "categories", :action => "show"})
      get("/categories/fondant/page/1").should route_to({:slug => "fondant", :controller => "categories", :action => "show", :page => "1"})
    end
  end
end

