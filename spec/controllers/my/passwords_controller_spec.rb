require "rails_helper"

describe My::PasswordsController do
  describe "#update" do
    context "when not logged in" do
      let(:user) { create(:user) }

      it "redirects you to the login page" do
        put :update, params: { id: user.id }
        expect(response).to redirect_to(login_path)
      end
    end

    context "when logged in" do
      let(:user) { create(:user) }

      before { http_login(user) }

      context "when the new password and the confirmation password does not match" do
        before :each do
          put :update, params: {
            id: user.id,
            user: {
              password: "foobar",
              password_confirmation: "barfoo"
            }
          }
        end

        it "displays an error on the page" do
          error_message = I18n.t("my.passwords.passwords_do_not_match")
          expect(flash[:error]).to eql(error_message)
        end

        it "renders the show template" do
          expect(response).to render_template(:index)
        end
      end

      context "when the password and confirmation match" do
        let(:new_password) { "booyakasham" }

        before :each do
          put :update, params: {
            id: user.id,
            user: {
              password: new_password,
              password_confirmation: new_password
            }
          }
        end

        it "updates the users password" do
          expect(user.reload.authenticate(new_password)).to be_truthy
        end
      end
    end
  end

  describe "#index" do
    context "when logged in" do
      let(:user) { create(:user) }

      before :each do
        http_login(user)
        get :index
      end

      context "when displaying a form to change the current password" do
        it "loads the user" do
          expect(assigns(:user)).to eql(user)
        end
      end
    end
  end
end
