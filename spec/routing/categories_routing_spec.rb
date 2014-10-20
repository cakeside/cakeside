require "rails_helper"

describe '/categories' do
  it "routes to #show" do
    expect(get: "/categories/fondant").to route_to(category: "fondant", controller: "cakes", action: "index")
  end

  it '/categories/cookies/page/2' do
    expect(get: "/categories/fondant/page/2").to route_to(category: "fondant", controller: "cakes", action: "index", page: '2')
  end
end
