require "spec_helper"

describe CategoriesController do
  describe "routing" do
    it "routes to #show" do
      get("/categories/fondant").should route_to({"id"=>"fondant", "controller"=>"categories", "action"=>"show"})
    end
  end
end

