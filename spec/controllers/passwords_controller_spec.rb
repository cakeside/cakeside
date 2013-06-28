require "spec_helper"

describe PasswordsController do
  describe :update do
    context "when not logged in" do
      let(:user) { FactoryGirl.create(:user) }

      it "should redirect you to the login page" do
        put :update, :id => user.id
        response.should redirect_to(new_user_session_path)
      end
    end
  end
end
