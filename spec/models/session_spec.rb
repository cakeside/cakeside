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

      before :each do
        user.password = 'password'
        user.save!
      end

      context "when the password is incorrect" do
        it "returns false" do
          expect(Session.login(user.email, 'blah')).to be_falsey
        end
      end

      context "when the password is correct" do
        it "returns a new session" do
          result = Session.login(user.email, 'password')
          expect(result).to be_truthy
          expect(result).to_not be_new_record
          expect(result.user).to eql(user)
        end
      end
    end
  end
end
