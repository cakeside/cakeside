require "rails_helper"

describe Session do
  describe ".login" do
    context "when the email is not known" do
      it "returns false" do
        expect(Session.login('blah@example.com', 'password')).to be_falsey
      end
    end

    context "when the email is known" do
      let(:user) { create(:user) }

      context "when the password is incorrect" do
        it "returns false" do
          expect(Session.login(user.email, 'blah')).to be_falsey
        end
      end
    end
  end
end
