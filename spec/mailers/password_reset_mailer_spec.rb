require "rails_helper"

describe PasswordResetMailer do
  describe '#send_password_reset_instructions_to' do
    let(:user) { build(:user, reset_password_token: SecureRandom.hex(32)) }
    let(:mail) { PasswordResetMailer.send_password_reset_instructions_to(user) }

    it "adds a subject" do
      expect(mail.subject).to eql("CakeSide - Password Reset Request")
    end

    it "sends to the users email" do
      expect(mail.to).to include(user.email)
    end

    it "should send from the correct address" do
      expect(mail.from).to include('noreply@cakeside.com')
    end

    it "includes their name" do
      expect(mail.body.encoded).to match(user.name)
    end
  end
end
