require "rails_helper"

module Admin
  describe SessionsController do
    context "logged in as admin" do
      let(:admin) { create(:admin) }

      before :each do
        http_login(admin)
      end

      describe "#index" do
        let(:active_session) { build(:user_session) }

        before :each do
          UserSession.stub(:active).and_return([active_session])
        end

        it "loads all the active sessions" do
          get :index
          expect(assigns(:user_sessions)).to include(active_session)
        end
      end

      describe "#destroy" do
        let(:user_session) { create(:active_session) }

        before :each do
          UserSession.stub(:find).with(user_session.id).and_return(user_session)
          user_session.stub(:revoke!).and_return(true)
          delete :destroy, id: user_session.id
        end

        it "revokes the specified session" do
          expect(user_session).to have_received(:revoke!)
        end

        it "redirects to the index page" do
          expect(response).to redirect_to(admin_sessions_path)
        end
      end
    end
  end
end