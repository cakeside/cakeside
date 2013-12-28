require "spec_helper"

describe PasswordsController do
  describe :update do
    context "when not logged in" do
      let(:user) { create(:user) }

      it "should redirect you to the login page" do
        put :update, :id => user.id
        response.should redirect_to(new_user_session_path)
      end
    end

    context "when logged in" do
      let(:user) { create(:user) }

      before { http_login(user) }

      context "when the new password and the confirmation password does not match" do
        before { put :update, :id => user.id, :user => { :password => 'foobar', :password_confirmation => 'barfoo' } }

        it "should display an error on the page" do
          flash[:error].should == I18n.t(:passwords_do_not_match)
        end

        it "should render the show template" do
          response.should render_template(:index)
        end
      end

      context "when the password and confirmation match" do
        let(:new_password) { 'booyakasham' }

        before :each do
          put :update, :id => user.id, :user => { :password => new_password, :password_confirmation => new_password }
        end

        it "should update the users password" do
          user.reload.valid_password?(new_password).should be_true
        end
      end
    end

  end

  describe :index do
    context 'when logged in' do
      let(:user) { create(:user) }

      before :each do
        http_login(user)
        get :index
      end

      context "when displaying a form to change the current password" do
        it "should load the user" do
          assigns(:user).should == user
        end
      end

    end
  end
end
