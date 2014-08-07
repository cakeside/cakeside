require "rails_helper"

describe SessionsController do
  describe "#new" do
    it "loads the login page" do
      get :new
      expect(response).to be_success
      expect(assigns(:session)).to be_new_record
    end
  end

  describe "#create" do
    context "when the username and password is correct" do
      let(:user_session) { build(:session, id: SecureRandom.uuid) }
      let(:username) { "joe" }
      let(:password) { "password" }

      before :each do
        Session.stub(:login).with(username, password).and_return(user_session)
        post :create, session: { username: username, password: password }
      end

      it "returns a valid session" do
        expect(cookies.signed[:cookie_monster]).to_not be_nil
        expect(cookies.signed[:cookie_monster]).to eql(user_session.id)
      end

      it "redirects to the dashboard" do
        expect(response).to redirect_to(my_dashboard_path)
      end
    end

    context "when the username is not known" do
      before :each do
        Session.stub(:login).and_return(nil)
      end

      it "returns an error" do
        post :create, session: { username: 'x', password: 'y' }
        expect(response).to render_template(:new)
        expect(flash[:error]).to_not be_empty
      end
    end
  end
end
