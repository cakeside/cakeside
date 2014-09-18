require "rails_helper"

describe PasswordsController do
  describe "#new" do
    it "loads a page to reset a password" do
      get :new
      expect(assigns(:user)).to be_new_record
    end
  end

  describe "#create" do
    let(:email) { Faker::Internet.email }

    it "sends a password reset email for the user" do
      allow(PasswordReset).to receive(:send_reset_instructions_to)

      post :create, user: { email: email }

      expect(PasswordReset).to have_received(:send_reset_instructions_to).with(email)
      expect(response).to redirect_to(new_session_path)
      expect(flash[:notice]).to_not be_empty
    end
  end
end
