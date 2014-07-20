require "rails_helper"

describe My::HomeController do
  context "when logged in" do
    let(:user){ create(:user) }
    before { http_login(user) }

    describe "#index" do
      it "should let me int" do
        get :index
        expect(response).to be_success
      end
    end
  end

  context "when not logged in" do
    it "redirects you to the home page" do
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end
end

