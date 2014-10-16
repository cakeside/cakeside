require "rails_helper"

describe Api::V1::LoginsController do
  context "when logging in with proper credentials" do
    let(:user) { create(:user) }

    it "should return the auth token" do
      post :create, { email: user.email, password: 'password' }
      expect(response.body).to eql({ auth_token: user.authentication_token }.to_json)
    end
  end

  context "when logging in with invalid credentials" do
    let(:user) { create(:user) }

    before { post :create, { email: user.email, password: user.password.reverse } }

    it "should return an empty auth token" do
      expect(response.body).to eql({ :auth_token => "" }.to_json)
    end
  end
end
