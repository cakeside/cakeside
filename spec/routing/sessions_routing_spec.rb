require "rails_helper"

describe '/sessions' do
  it "routes to the login page" do
    expect(get: '/sessions/new').to route_to('sessions#new')
  end

  it "routes to the login action" do
    expect(post: '/sessions').to route_to('sessions#create')
  end

  it "routes to the logout action" do
    expect(delete: '/sessions/me').to route_to('sessions#destroy', id: 'me')
  end
end
