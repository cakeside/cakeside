require "rails_helper"

describe PasswordReset do
  describe ".send_reset_instructions_to" do
    let(:user) { create(:user, reset_password_token: nil, reset_password_sent_at: nil) }
    let(:mailer) { double(deliver_later: true) }

    before :each do
      allow(PasswordResetMailer).
        to receive(:send_password_reset_instructions_to).
        with(user).
        and_return(mailer)
    end

    it "creates a new reset token for the user" do
      PasswordReset.send_reset_instructions_to(user.email)
      user.reload
      expect(user.reset_password_token).to_not be_nil
      expect(user.reset_password_sent_at).to_not be_nil
    end

    it "sends an email to the user" do
      PasswordReset.send_reset_instructions_to(user.email)
      expect(mailer).to have_received(:deliver_later)
    end

    it "does nothing if the email is not known" do
      PasswordReset.send_reset_instructions_to(FFaker::Internet.email)
      expect(mailer).to_not have_received(:deliver_later)
    end
  end

  describe ".reset" do
    let(:reset_token) { SecureRandom.hex(32) }
    let(:password) { SecureRandom.hex(8) }
    let!(:user) { create(:user, reset_password_token: reset_token) }

    it "changes the users password" do
      PasswordReset.reset(reset_token, password)
      user.reload
      expect(user.authenticate(password)).to be_truthy
    end

    it "deletes the reset token" do
      PasswordReset.reset(reset_token, password)
      user.reload
      expect(user.reset_password_token).to be_nil
      expect(user.reset_password_sent_at).to be_nil
    end

    it "does nothing if the token cannot be found" do
      PasswordReset.reset(SecureRandom.hex(32), password)
    end
  end
end
