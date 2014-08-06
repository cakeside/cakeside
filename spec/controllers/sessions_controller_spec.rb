require "rails_helper"

describe SessionsController do
  describe "#new" do
    it "loads the login page" do
      get :new
      expect(response).to be_success
      expect(assigns(:session)).to be_new_record
    end
  end
end
