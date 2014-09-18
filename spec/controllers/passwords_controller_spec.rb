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

  describe "#edit" do
    let(:reset_token) { SecureRandom.hex(32) }
    let(:user) { build(:user) }

    it "loads the password reset token" do
      allow(User).to receive(:find_by).with(reset_password_token: reset_token).and_return(user)
      get :edit, id: reset_token
      expect(assigns(:user)).to eql(user)
    end

    it "redirects to the homepage if the user cannot be found" do
      allow(User).to receive(:find_by).with(reset_password_token: reset_token).and_return(nil)
      get :edit, id: reset_token
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#update" do
    let(:user) { double(change_password: true, valid?: true) }
    let(:reset_token) { SecureRandom.hex(32) }
    let(:password) { SecureRandom.hex(8) }

    it "resets the users password" do
      allow(PasswordReset).to receive(:reset).with(reset_token, password).and_return(user)

      patch :update, id: reset_token, user: { password: password }
      expect(PasswordReset).to have_received(:reset).with(reset_token, password)
      expect(response).to redirect_to(new_session_path)
    end
  end
end
