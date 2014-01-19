require "spec_helper"

describe DashboardController do
  context "#index" do
    let(:user) { create(:user) }
    let!(:activity) { create(:activity, user: user) }

    before :each do
      http_login(user)
    end

    it "loads the most recent activities" do
      get :index
      assigns(:activities).should include(activity)
    end
  end
end
