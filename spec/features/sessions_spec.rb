require "rails_helper"

describe "Logins" do
  describe "GET /login" do
    subject { LoginPage.new }
    let(:error_message) { I18n.t("sessions.create.failure.invalid") }

    before :each do
      subject.visit_page
    end

    context "when an email is registered" do
      let!(:user) { create(:user, password: "password") }

      context "when the password is correct" do
        before :each do
          subject.login_with(email: user.email, password: "password")
        end

        it "logs the user in" do
          expect(page).to have_content("Log Out")
        end

        it "has no errors" do
          expect(page).to_not have_content(error_message)
        end
      end

      context "when the password is incorrect" do
        before :each do
          subject.login_with(email: user.email, password: "wrong")
        end

        it "displays an error" do
          expect(page).to have_content(error_message)
        end
      end
    end

    context "when an email is not known" do
      before :each do
        subject.login_with(email: "test@example.com", password: "password")
      end

      it "displays an error message" do
        expect(page).to have_content(error_message)
      end
    end
  end
end
