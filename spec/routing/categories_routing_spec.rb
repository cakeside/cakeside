require "rails_helper"

describe CategoriesController do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/categories/fondant").to route_to(slug: "fondant", controller: "categories", action: "show")
    end
  end
end

