require "spec_helper"


describe "/comments" do
  it "routes to the create action" do
    expect({ :post => '/comments' }).to route_to(controller: 'comments', action: 'create')
  end
end
