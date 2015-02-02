require "rails_helper"

describe "password retrieval" do
  context "when a user attempts to retrieve their password" do
    subject { PasswordResetRequestPage.new }
    let(:user) { create(:user) }
    let(:error_message) { I18n.t("passwords.send_instructions") }

    it "sends them an email with instructions" do
      subject.visit_page
      subject.reset_password(user.email)
      expect(page).to have_content(error_message)
    end
  end

  context "when a reset link is sent" do
    let(:user) { create(:user, reset_password_token: SecureRandom.hex(32)) }
    subject { PasswordResetPage.new(user.reset_password_token) }

    it "lets them reset their password" do
      subject.visit_page
      subject.change_password_to("donkey")
      expect(current_path).to eql(new_session_path)
      expect(user.reload.authenticate("donkey")).to be_truthy
    end
  end
end
