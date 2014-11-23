require "rails_helper"

describe SessionsController do
  describe "#new" do
    context "when not logged in" do
      it "loads the login page" do
        get :new
        expect(response).to be_success
        expect(assigns(:session)).to be_new_record
      end
    end

    context "when already logged in" do
      let(:user) { build(:user) }

      before { http_login(user) }

      it "redirects to the dashboard" do
        get :new
        expect(response).to redirect_to(my_dashboard_path)
      end
    end
  end

  describe "#create" do
    context "when the username and password is correct" do
      let(:user_session) { build(:user_session, id: SecureRandom.uuid) }
      let(:username) { "joe" }
      let(:password) { "password" }

      before :each do
        User.stub(:login).with(username, password).and_return(user_session)
        post :create, session: { username: username, password: password }
      end

      it "returns a valid session" do
        expect(cookies.signed[:raphael]).to_not be_nil
        expect(cookies.signed[:raphael]).to eql(user_session.key)
      end

      it "redirects to the dashboard" do
        expect(response).to redirect_to(my_dashboard_path)
      end
    end

    context "when the username is not known" do
      before :each do
        User.stub(:login).and_return(nil)
      end

      it "returns an error" do
        post :create, session: { username: 'x', password: 'y' }
        expect(response).to redirect_to(login_path)
        expect(flash[:error]).to_not be_empty
      end
    end
  end

  describe "#destroy" do
    before :each do
      request.cookies[:raphael] = SecureRandom.uuid
      delete :destroy, id: "me"
    end

    it "removes the cookie" do
      expect(cookies[:raphael]).to be_nil
    end

    it "redirects to the homepage" do
      expect(response).to redirect_to(root_path)
    end
  end
end
