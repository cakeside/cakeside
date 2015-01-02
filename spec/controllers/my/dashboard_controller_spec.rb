require "rails_helper"

describe My::DashboardController do
  context "#index" do
    let(:user) { create(:user) }
    let!(:activity) { create(:activity, user: user) }

    before :each do
      http_login(user)
    end

    it "loads the most recent activities" do
      get :index
      expect(assigns(:activities)).to match_array([activity])
    end
  end
end
