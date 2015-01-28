require "rails_helper"

describe Api::V1::LoginsController do
  render_views

  context "when logging in with proper credentials" do
    let(:user) { create(:user) }

    it "returns the auth token" do
      post :create, { email: user.email, password: 'password' }
      expected_json = { auth_token: user.authentication_token }.to_json
      expect(response.body).to eql(expected_json)
    end
  end

  context "when logging in with invalid credentials" do
    let(:user) { create(:user) }

    before { post :create, { email: user.email, password: user.password.reverse } }

    it "returns an empty auth token" do
      expect(response.body).to eql({ auth_token: "" }.to_json)
    end
  end
end
