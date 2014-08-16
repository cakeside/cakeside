require "rails_helper"

module Admin
  describe SessionsController do
    context "logged in as admin" do
      let(:admin) { create(:admin) }

      before :each do
        http_login(admin)
      end

      describe "index" do
        let(:active_session) { build(:user_session) }

        before :each do
          UserSession.stub(:active).and_return([active_session])
        end

        it "loads all the active sessions" do
          get :index
          expect(assigns(:sessions)).to include(active_session)
        end
      end
    end
  end
end
