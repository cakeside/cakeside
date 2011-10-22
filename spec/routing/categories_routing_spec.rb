require "spec_helper"

describe CategoriesController do
  describe "routing" do

    it "routes to #show" do
      get("/categories/fondant").should route_to("categories#show", :id => "fondant")
    end

  end
end
